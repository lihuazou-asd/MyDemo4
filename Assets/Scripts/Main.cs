using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using Unity.VisualScripting;
using UnityEngine;
using UnityEngine.UI;

public class Main : MonoBehaviour
{
    // Start is called before the first frame update
    void Start()
    {
        // ABUpdateMgr.Instance.CheckUpABInfo(updateTips);
        LuaMgr.GetInstance().Init();
        LuaMgr.GetInstance().DoLuaFile("Main");
        // SpriteRenderer spriteRenderer = new SpriteRenderer();
        // spriteRenderer.flipX = 
        // gameObject.transform.LookAt()
        
    }
    private void updateTips(string tip){
        print(tip);
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
