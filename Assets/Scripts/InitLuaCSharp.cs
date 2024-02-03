using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;
using XLua;

public static class InitLuaCSharp
{
    [CSharpCallLua]
    public static List<Type> csharpCallLuaList = new List<Type>(){
        typeof(UnityAction<int>),
        typeof(UnityAction<float>)
    };

    [LuaCallCSharp]
    public static List<Type> luaCallCSharpList = new List<Type>(){
        typeof(GameObject)
    };
}
