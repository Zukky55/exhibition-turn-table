using System.Collections;
using System.Collections.Generic;
using UnityEngine;

/// <summary>
/// turn button
/// </summary>
public class TurnButton : MonoBehaviour
{
    /// <summary>turnさせる向き</summary>
    [SerializeField] TurnTable.Direction dir;
    /// <summary>ターンテーブルクラス</summary>
    TurnTable turnTable;

    private void Awake()
    {
        turnTable = GameObject.FindGameObjectWithTag("TurnTable").GetComponent<TurnTable>();
    }

    public void Turn()
    {
        turnTable.Rotation(dir);
    }
}
