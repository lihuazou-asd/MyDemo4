using System.Collections;
using System.Collections.Generic;
using System.Drawing.Printing;
using System.IO;
using UnityEditor;
using UnityEngine;
using UnityEngine.Networking;

public class UpLoadAB : Editor
{
    static string path = Application.dataPath + "/ArtRes/AB/PC";
    static string serverPath = "http://127.0.0.1/HTTPServer/";
    [MenuItem("AB包工具/3.上传所有AB包至服务器")]
    static void UpLoadHttp(){

        DirectoryInfo directoryInfo = Directory.CreateDirectory(path);

        FileInfo[] fileInfos = directoryInfo.GetFiles();

        UpLoad(fileInfos);
    }

    static void UpLoad(FileInfo[] fileInfos){
        List<IMultipartFormSection> dataList = new List<IMultipartFormSection>();
        
        foreach(FileInfo fileInfo in fileInfos){
            if(fileInfo.Extension == ""||fileInfo.Extension == ".txt"){
                dataList.Add(new MultipartFormFileSection(fileInfo.Name,File.ReadAllBytes(path+"/"+fileInfo.Name)));
            }
        }
        UnityWebRequest unityWebRequest = UnityWebRequest.Post(serverPath,dataList);
        unityWebRequest.SetRequestHeader("If-Match", "*");
        unityWebRequest.SendWebRequest();
        while (!unityWebRequest.isDone)
        {
        }
        if(unityWebRequest.result == UnityWebRequest.Result.Success){
            Debug.Log("上传至HTTP服务器成功");
        }
        else{
            Debug.LogError("上传至HTTP服务器失败");
        }
    }
}
