using System.Collections;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;
using UnityEngine.UI;

/// <summary>
/// 表示されているモデルのキャプションを表示するクラス
/// </summary>
public class CaptionDisplayer : MonoBehaviour
{
    /// <summary>Caption text</summary>
    [SerializeField] Text captionText;
    TurnTable turnTable;

    private void Awake()
    {
        turnTable = GameObject.FindGameObjectWithTag("TurnTable").GetComponent<TurnTable>();
    }

    private void OnEnable()
    {
        TurnTable.DelayOnTurnEvent += DisplayCaption;
    }

    private void OnDisable()
    {
        TurnTable.DelayOnTurnEvent -= DisplayCaption;
    }

    private void DisplayCaption()
    {
        // 対象のモデルに保存されているキャプション情報を表示させる
        captionText.text = turnTable.TargetModel.CaptionText;
    }
}
