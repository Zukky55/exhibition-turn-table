using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BackgroundManager : MonoBehaviour
{
    TurnTable turnTable;
    MeshRenderer mesh;

    private void OnEnable()
    {
        TurnTable.DelayOnTurnEvent += ChangeBackgroundColor;
    }

    private void OnDisable()
    {
        TurnTable.DelayOnTurnEvent -= ChangeBackgroundColor;
    }

    private void Awake()
    {
        turnTable = GameObject.FindGameObjectWithTag("TurnTable").GetComponent<TurnTable>();
        mesh = GetComponent<MeshRenderer>();
    }

    private void Start()
    {
        ChangeBackgroundColor();
    }

    private void ChangeBackgroundColor()
    {
        mesh.material.color = turnTable.TargetModel.backgroundColor;
    }
}
