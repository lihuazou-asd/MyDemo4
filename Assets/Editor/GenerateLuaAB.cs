using System.Collections;
using System.Collections.Generic;
using System.IO;
using UnityEditor;
using UnityEngine;


public class GenerateLuaAB
{
    static string path = Application.dataPath + "/ArtRes/Lua";
    static string newPath = path+"/LuaTxt";
    [MenuItem("AB包工具/1.将全部Lua打入AB包")]
    static void GenerateLuaAssetBundle()
    {
        if (!Directory.Exists(path))
        {
            Debug.LogError($"{path}不存在");
            return;
        }
        
        string[] fileNames = Directory.GetFiles(path,"*.lua");
        if(fileNames.Length==0){
            Debug.LogError($"{path}路径不存在Lua文件");
            return;
        }
        if (!Directory.Exists(newPath))
        {
            Debug.LogError($"{newPath}不存在");
            return;
        }
        else{
            string[] oldFileStrs = Directory.GetFiles(newPath);
            for (int i = 0; i < oldFileStrs.Length; i++)
            {
                File.Delete(oldFileStrs[i]);
            }
        }
        List<string> newFileNames = new List<string>();
        string fileName;
        for(int i = 0; i < fileNames.Length; ++i)
        {
            //得到新的文件路径 用于拷贝
            fileName = newPath +"/"+ fileNames[i].Substring(fileNames[i].LastIndexOf("\\")+1) + ".txt";
            newFileNames.Add(fileName);
            File.Copy(fileNames[i], fileName);
        }

        AssetDatabase.Refresh();

        //刷新过后再来改制定包 因为 如果不刷新 第一次改变 会没用
        for (int i = 0; i < newFileNames.Count; i++)
        {
            AssetImporter importer = AssetImporter.GetAtPath( newFileNames[i].Substring(newFileNames[i].IndexOf("Assets")));
            if(importer != null)
                importer.assetBundleName = "lua";
        }
    }
}
