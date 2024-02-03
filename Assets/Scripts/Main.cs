using System.Collections;
using System.Collections.Generic;
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
        print(Application.persistentDataPath);
        // Slider slider
        // Button
    }
    private void updateTips(string tip){
        print(tip);
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
