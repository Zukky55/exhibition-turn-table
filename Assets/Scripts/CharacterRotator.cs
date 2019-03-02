using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CharacterRotator : MonoBehaviour
{
    [SerializeField] float turnSpeed = 10f;
    [SerializeField] bool isTurning;

    private void Update()
    {
        if (!isTurning)
        {
            return;
        }

        transform.Rotate(Vector3.up, Time.deltaTime * turnSpeed);
    }
}
