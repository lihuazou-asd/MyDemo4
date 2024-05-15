using System.Collections;
using System.Collections.Generic;
using System.IO;
using UnityEngine;
using XLua;
public class LuaMgr : BaseManager<LuaMgr>
{
    private LuaEnv luaEnv;

    public LuaTable Global
    {
        get
        {
            return luaEnv.Global;
        }
    }

    public void Init(){
        if(luaEnv!=null) return;
        luaEnv = new LuaEnv();
        luaEnv.AddLoader(MyCustomLoader);
        //luaEnv.AddLoader(MyCustomABLoader);
    }
    private byte[] MyCustomABLoader(ref string fileName){
        
        TextAsset lua = ABMgr.GetInstance().LoadRes("lua",fileName+".lua") as TextAsset;
        
        if(lua !=null){
            return lua.bytes;
        }
        else{
            Debug.Log("MyCustomABLoader重定向失败，文件名为：" + fileName);
        }

        return null;
    }

    private byte[] MyCustomLoader(ref string fileName){
        string path = Application.dataPath + "/ArtRes/Lua/"+fileName+".lua";
        if(File.Exists(path)){
            return File.ReadAllBytes(path);
        }
        else{
            Debug.Log("MyCustomLoader重定向失败，文件名为" + path);
        }
        return null;
    }

    
    public void DoLuaFile(string file)
    {
        luaEnv.DoString($"require('{file}')");
    }
    public void DoString(string str)
    {
        if(luaEnv == null)
        {
            Debug.Log("解析器未初始化");
            return;
        }
        luaEnv.DoString(str);
    }
    public void Tick()
    {
        if (luaEnv == null)
        {
            Debug.Log("解析器未初始化");
            return;
        }
        luaEnv.Tick();
    }
    public void Dispose()
    {
        if (luaEnv == null)
        {
            Debug.Log("解析器未初始化");
            return;
        }
        luaEnv.Dispose();
        luaEnv = null;
    }

}
