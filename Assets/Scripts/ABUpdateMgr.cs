using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Net;
using System.Threading.Tasks;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.Networking;

public class ABUpdateMgr : MonoBehaviour
{
    private static bool haveNewVersion = false;

    public static bool HaveNewVersion{
        get{
            return haveNewVersion;
        }
    }
    private static string HTTPServer = "http://127.0.0.1/HTTPServer/";
    private static string localPath = Application.persistentDataPath;
    private static ABUpdateMgr instance;
    public static ABUpdateMgr Instance{
        get{
            if(instance == null){
                GameObject gameObject = new GameObject("ABUpdateMgr");
                instance = gameObject.AddComponent<ABUpdateMgr>();
            }
            return instance;
        }
    }

    private Dictionary<string,ABInfo> localABInfoDic = new Dictionary<string, ABInfo>();
    private Dictionary<string,ABInfo> remoteABInfoDic = new Dictionary<string, ABInfo>();

    private List<string> needToDownLoadAB = new List<string>();

    public void CheckUpABInfo(UnityAction<string> upDateTips){
        localABInfoDic.Clear();
        remoteABInfoDic.Clear();
        needToDownLoadAB.Clear();
        upDateTips?.Invoke("开始下载AB包对比文件");
        DownLoadABCompareFile((isOver)=>{
            if(isOver){
                upDateTips?.Invoke("AB包对比文件下载成功");
                GetRemoteABCompareFileInfo(remoteABInfoDic);
                upDateTips?.Invoke("获取远端AB包信息成功");
                GetLocalABCompareFileInfo((isOver)=>{
                    if(isOver){
                        upDateTips?.Invoke("获取本地AB包信息成功");
                        CompareLocalAndRemote(localABInfoDic,remoteABInfoDic);
                        upDateTips?.Invoke("比较两段AB包信息成功");
                        
                    }
                    else{
                        upDateTips?.Invoke("获取本地AB包信息失败");
                    }
                });
            }
            else{
                upDateTips?.Invoke("AB包对比文件下载错误");
            }
        });
    }

    public void StartUpdate(UnityAction<string> upDateTips){
        if(true){
            DownABFile((isOver)=>{
                if(isOver){
                    upDateTips?.Invoke("更新AB包成功");
                    File.WriteAllText(localPath+"/ABCompareInfo.txt",File.ReadAllText(localPath+"/ABCompareInfo_TMP.txt"));
                }
                else{
                    upDateTips?.Invoke("更新AB包失败");
                }
            });
        }
    }

    private async void DownLoadABCompareFile(UnityAction<bool> unityAction){

        bool isOver = false;
        await Task.Run(()=>{
            isOver = DownLoadFile("ABCompareInfo.txt",localPath+"/ABCompareInfo_TMP.txt");
        });

        unityAction?.Invoke(isOver);
    }
    private void GetRemoteABCompareFileInfo(Dictionary<string,ABInfo> dic){
        string[] infos = File.ReadAllText(localPath+"/ABCompareInfo_TMP.txt").Split("|");
        foreach(string info in infos){
            string[] singleInfo = info.Split(" ");
            dic.Add(singleInfo[0],new ABInfo(singleInfo[0],Convert.ToInt64(singleInfo[1]),singleInfo[2]));
        }
    }
    private void GetLocalABCompareFileInfo(UnityAction<bool> unityAction){
        if(File.Exists(localPath+"/ABCompareInfo.txt")){
            StartCoroutine(GetLocalABCompareFile(localPath+"/ABCompareInfo.txt",unityAction));
        }
        else if(File.Exists(Application.streamingAssetsPath+"/ABCompareInfo.txt")){
            StartCoroutine(GetLocalABCompareFile(Application.streamingAssetsPath+"/ABCompareInfo.txt",unityAction));
        }
        else{
            unityAction?.Invoke(true);
        }
    }

    private IEnumerator GetLocalABCompareFile(string path,UnityAction<bool> unityAction){
        UnityWebRequest unityWebRequest = UnityWebRequest.Get(path);
        yield return unityWebRequest.SendWebRequest();

        if(unityWebRequest.result == UnityWebRequest.Result.Success){
            GetLocalABCompareInfo(unityWebRequest.downloadHandler.text,localABInfoDic);
            unityAction?.Invoke(true);
        }
        else{
            unityAction?.Invoke(false);
        }

    }
    private void GetLocalABCompareInfo(string infosString,Dictionary<string,ABInfo> dic){
        string[] infos = infosString.Split("|");
        foreach(string info in infos){
            string[] singleInfo = info.Split(" ");
            dic.Add(singleInfo[0],new ABInfo(singleInfo[0],Convert.ToInt64(singleInfo[1]),singleInfo[2]));
        }
    }

    private void CompareLocalAndRemote(Dictionary<string,ABInfo> dicLocal,Dictionary<string,ABInfo> dicRemote){

        foreach(string abName in dicRemote.Keys){
            if(!dicLocal.ContainsKey(abName)){
                needToDownLoadAB.Add(abName);

            }
            else{
                if(dicRemote[abName].md5 != dicLocal[abName].md5){
                    needToDownLoadAB.Add(abName);
                }
                
                dicLocal.Remove(abName);
                
            }
        }
        if(needToDownLoadAB.Count==0&&dicLocal.Count==0){
            haveNewVersion = false;
            return;
        }
        else{
            haveNewVersion = true;
        }
        foreach(string abName in dicLocal.Keys){
            if(File.Exists(localPath+"/"+abName))
                File.Delete(localPath+"/"+abName);
        }

    }
    private async void DownABFile(UnityAction<bool> unityAction){
        string localPath = Application.persistentDataPath + "/";
        bool isOver = false;
        int reDownNumMax = 5;
        List<string> tempList = new List<string>();
        while(needToDownLoadAB.Count>0&&reDownNumMax>0){
            for(int i = 0;i<needToDownLoadAB.Count;i++){
                await Task.Run(()=>{
                    isOver = DownLoadFile(needToDownLoadAB[i],localPath+needToDownLoadAB[i]);
                });
                if(isOver){
                    tempList.Add(needToDownLoadAB[i]);
                }
            }
            for(int i = 0;i<tempList.Count;i++){
                needToDownLoadAB.Remove(tempList[i]);
            }
            reDownNumMax--;
        }
        unityAction?.Invoke(needToDownLoadAB.Count==0);
    }
    private bool DownLoadFile(string downLoadFile,string savePath){
        try
        {
            HttpWebRequest request = HttpWebRequest.Create(new Uri(HTTPServer+downLoadFile)) as HttpWebRequest;
            request.Method = WebRequestMethods.Http.Head;
            request.Timeout = 2000;

            HttpWebResponse response =  request.GetResponse() as HttpWebResponse;
            if(response.StatusCode == HttpStatusCode.OK){
                response.Close();
                HttpWebRequest downLoadRequest = HttpWebRequest.Create(HTTPServer+downLoadFile) as HttpWebRequest;
                downLoadRequest.Method = WebRequestMethods.Http.Get;

                HttpWebResponse downLoadResponse = downLoadRequest.GetResponse() as HttpWebResponse;

                Stream responStream = downLoadResponse.GetResponseStream();

                using(FileStream file = File.Create(savePath)){
                    byte[] bytes = new byte[2048];
                    int contentLength = responStream.Read(bytes,0,bytes.Length);
                    while(contentLength!=0){
                        file.Write(bytes,0,contentLength);
                        contentLength = responStream.Read(bytes,0,bytes.Length);
                    }
                    file.Close();
                    responStream.Close();

                }
                return true;
            }
            else{
                return false;
            }
        }
        catch (WebException w)
        {
            Debug.Log("下载出错" + w.Message + w.Status);
        }
        return false;
    }
}

public class ABInfo{
    public string name;
    public long size;
    public string md5;

    public ABInfo(string name,long size,string md5){
        this.name = name;
        this.size = size;
        this.md5 = md5;
    }

}
