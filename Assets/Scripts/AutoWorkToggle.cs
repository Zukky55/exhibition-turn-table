using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

/// <summary>
/// TurnTableのオート機能をOn,Off切り替えるトグルクラス
/// </summary>
public class AutoWorkToggle : MonoBehaviour
{
    [SerializeField] Text autoStatusText;
    TurnTable turnTable;

    private void Awake()
    {
        turnTable = GameObject.FindGameObjectWithTag("TurnTable").GetComponent<TurnTable>();

        if (turnTable.Toggle)
        {
            autoStatusText.text = "Auto On";
        }
        else
        {
            autoStatusText.text = "Auto Off";
        }
    }

    public void Toggle()
    {
        if (turnTable.Toggle)
        {
            turnTable.Toggle = false;
            autoStatusText.text = "Auto Off";
        }
        else
        {
            turnTable.Toggle = true;
            autoStatusText.text = "Auto On";
        }
    }
}
