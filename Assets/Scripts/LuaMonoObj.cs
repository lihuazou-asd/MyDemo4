using System.Collections;
using System.Collections.Generic;
using Unity.VisualScripting;
using UnityEngine;
using UnityEngine.Events;

public class LuaMonoObj : MonoBehaviour
{

    private UnityAction start;
    private UnityAction update;
    private UnityAction fixedUpdate;
    private UnityAction lateUpdate;
    private UnityAction onEnable;
    private UnityAction onDisable;
    private UnityAction onDestroy;
    // Start is called before the first frame update
    void Start()
    {
        if(start!=null){
            start();
        }
    }

    // Update is called once per frame
    void Update()
    {
        if(update!=null){
            update();
        }
    }

    /// <summary>
    /// This function is called every fixed framerate frame, if the MonoBehaviour is enabled.
    /// </summary>
    void FixedUpdate()
    {
        if(fixedUpdate!=null){
            fixedUpdate();
        }
    }

    /// <summary>
    /// LateUpdate is called every frame, if the Behaviour is enabled.
    /// It is called after all Update functions have been called.
    /// </summary>
    void LateUpdate()
    {
        if(lateUpdate!=null){
            lateUpdate();
        }
    }

    /// <summary>
    /// This function is called when the object becomes enabled and active.
    /// </summary>
    void OnEnable()
    {
        if(onEnable!=null){
            onEnable();
        }
    }

    /// <summary>
    /// This function is called when the behaviour becomes disabled or inactive.
    /// </summary>
    void OnDisable()
    {
        if(onDisable!=null){
            onDisable();
        }
    }

    /// <summary>
    /// This function is called when the MonoBehaviour will be destroyed.
    /// </summary>
    void OnDestroy()
    {
        if(onDestroy!=null){
            onDestroy();
        }
        start = null;
        update = null;
        fixedUpdate = null;
        lateUpdate = null;
        onDisable = null;
        onEnable = null;
        onDestroy = null; 
    }

    public void AddOrRemoveListener(UnityAction fun,E_LifeFun_Type type,bool IsAdd = true){
        switch (type)
        {
            case E_LifeFun_Type.Start:
                if(IsAdd) start+=fun;
                else start-=fun;
                break;
            case E_LifeFun_Type.Update:
                if(IsAdd) update+=fun;
                else update-=fun;
                break;
            case E_LifeFun_Type.LateUpdate:
                if(IsAdd) lateUpdate+=fun;
                else lateUpdate-=fun;
                break;
            case E_LifeFun_Type.FixedUpdate:
                if(IsAdd) fixedUpdate+=fun;
                else fixedUpdate-=fun;
                break;
            case E_LifeFun_Type.OnEnable:
                if(IsAdd) onEnable+=fun;
                else onEnable-=fun;
                break;
            case E_LifeFun_Type.OnDisable:
                if(IsAdd) onDisable+=fun;
                else onDisable-=fun;
                break;
            case E_LifeFun_Type.OnDestroy:
                if(IsAdd) onDestroy+=fun;
                else onDestroy-=fun;
                break;
        }

    }
}

public enum E_LifeFun_Type{
    Start,
    Update,
    LateUpdate,
    FixedUpdate,
    OnEnable,
    OnDestroy,
    OnDisable,
}
