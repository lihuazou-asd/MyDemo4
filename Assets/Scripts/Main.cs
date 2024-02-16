using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using Unity.VisualScripting;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

public class Main : MonoBehaviour
{
    // Start is called before the first frame update
    void Start()
    {
        // ABUpdateMgr.Instance.CheckUpABInfo(updateTips);
        LuaMgr.GetInstance().Init();
        LuaMgr.GetInstance().DoLuaFile("Main");
        // Button button;
        // button.transition = Selectable.Transition.None
        // EventTrigger trigger = GetComponent<EventTrigger>();
        // EventTrigger.Entry entry = new EventTrigger.Entry();
        // entry.eventID = EventTriggerType.PointerExit
        // entry.callback.AddListener((data) => { luaFunction.Call(); });
        // BaseEventData baseEventData;
        // PointerEventData s;
        // s.position
        // trigger.triggers.Add(entry);
        // RectTransform rectTransform = new RectTransform();
        
        // rectTransform.rect.height;
    }
    private void updateTips(string tip){
        print(tip);
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
