using System.Collections;
using System.Collections.Generic;
using System.IO;
using UnityEngine;

public class ABMgr : SingletonAutoMono<ABMgr>
{
    private AssetBundle mainAB = null;
    private AssetBundleManifest manifest = null;
    private Dictionary<string, AssetBundle> abDic = new Dictionary<string, AssetBundle>();

    private string StreamingAssetsPathUrl
    {
        get
        {
            return Application.streamingAssetsPath + "/";
        }
    }
    private string PersistentPathUrl
    {
        get
        {
            return Application.persistentDataPath + "/";
        }
    }
    
    public void LoadAB(string abName){
        if(mainAB == null){
            mainAB = AssetBundle.LoadFromFile(ExistABPath("PC"));
            manifest = mainAB.LoadAsset<AssetBundleManifest>("AssetBundleManifest");
        }
        AssetBundle ab = null;
        string[] abDependencies = manifest.GetAllDependencies(abName);
        for(int i = 0;i<abDependencies.Length;i++){
            if(!abDic.ContainsKey(abDependencies[i])){
                ab = AssetBundle.LoadFromFile(ExistABPath(abDependencies[i]));
                abDic.Add(abDependencies[i],ab);
            }
        }

        if(!abDic.ContainsKey(abName)){
            abDic.Add(abName,AssetBundle.LoadFromFile(ExistABPath(abName)));
        }
    }

    public Object LoadRes(string abName,string resName,System.Type type){
        LoadAB(abName);

        Object obj = abDic[abName].LoadAsset(resName,type);
        if(obj is GameObject){
            return Instantiate(obj);
        }
        else{
            return obj;
        }

    }
    public Object LoadRes(string abName,string resName){
        LoadAB(abName);

        Object obj = abDic[abName].LoadAsset(resName);
        if(obj is GameObject){
            return Instantiate(obj);
        }
        else{
            return obj;
        }

    }
    private string ExistABPath(string abName){
        if(File.Exists(PersistentPathUrl+abName)){
            return PersistentPathUrl+abName;
        }
        else{
            return StreamingAssetsPathUrl+abName;
        }
    }


    public void UnLoad(string abName)
    {
        if( abDic.ContainsKey(abName) )
        {
            abDic[abName].Unload(false);
            abDic.Remove(abName);
        }
    }


    public void ClearAB()
    {
        AssetBundle.UnloadAllAssetBundles(false);
        abDic.Clear();
        mainAB = null;
        manifest = null;
    }
    
}
