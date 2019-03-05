using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class LightManager : MonoBehaviour
{
    TurnTable turnTable;

    private void OnEnable()
    {
        TurnTable.DelayOnTurnEvent += LightAdjustment;
    }

    private void OnDisable()
    {
        TurnTable.DelayOnTurnEvent -= LightAdjustment;
    }

    private void Awake()
    {
        turnTable = GameObject.FindGameObjectWithTag("TurnTable").GetComponent<TurnTable>();
    }

    private void LightAdjustment()
    {
        //transform.rotation = Quaternion.Euler(turnTable.TargetModel.LightVector);
        //iTween.RotateTo(gameObject,iTween.Hash
    }

    private void Update()
    {
        iTween.RotateUpdate(gameObject, iTween.Hash("rotation", turnTable.TargetModel.LightVector));
    }
}
