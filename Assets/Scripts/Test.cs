using System;
using System.Collections;
using System.Collections.Generic;
using Unity.Mathematics;
using UnityEngine;

public class Test : MonoBehaviour
{
    GameObject A;
    GameObject B;
    // Start is called before the first frame update
    void Start()
    {
        float distance = Vector3.Distance(A.transform.position,B.transform.position);
        Vector3 vector = Vector3.Normalize(B.transform.position-A.transform.position);
        double cos =  Vector3.Dot(vector,A.transform.forward);
        double angle = Math.Acos(cos)*Mathf.Rad2Deg;
        if(distance<5&&angle>=-15&&angle<=15){
            //逻辑判断
        }
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    public void Test1()
    {
        
    }
}


