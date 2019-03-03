using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CameraManager : MonoBehaviour
{
    [SerializeField] float moveTime = 1f;

     TurnTable turnTable;


    private void OnEnable()
    {
        TurnTable.DelayOnTurnEvent += CameraAdjustment;
    }

    private void OnDisable()
    {
        TurnTable.DelayOnTurnEvent -= CameraAdjustment;
    }

    private void Awake()
    {
        turnTable = GameObject.FindGameObjectWithTag("TurnTable").GetComponent<TurnTable>();
    }

    private void CameraAdjustment()
    {
        iTween.MoveTo(gameObject, turnTable.TargetModel.ProperCameraPosition, moveTime);
    }
}
