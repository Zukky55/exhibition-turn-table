using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TestCamera : MonoBehaviour
{
    [SerializeField] Vector3 targetVec;
    // Use this for initialization
    void Start()
    {
        transform.rotation = Quaternion.Euler(targetVec);

    }
}
