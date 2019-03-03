using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System.Linq;

public class TurnTable : MonoBehaviour
{
    #region Properties
    int currentModelCount
    {
        get
        {
            int models = GameObject.FindGameObjectsWithTag("Model").Length;
            return models;
        }
    }

    /// <summary>モデルタグのゲームオブジェクトリスト</summary>
    public List<GameObject> ModelObjects { get; private set; }
    /// <summary>modelObjectsのモデルクラスリスト</summary>
    public List<Model> Models { get; private set; }
    /// <summary>キャプション表示対象モデルクラス</summary>
    public Model TargetModel { get; private set; }
    /// <summary>toggle</summary>
    public bool Toggle { get; set; }
    #endregion

    #region EventSystem
    public delegate void TurnTableEvent();
    public static event TurnTableEvent OnTurn = () => { };
    public static event TurnTableEvent DelayOnTurnEvent = () => { };
    #endregion

    #region Variables
    /// <summary>オート機能を発動するインターバル</summary>
    [SerializeField] float autoTurnInterval = 5f;
    /// <summary>円周</summary>
    const float circumference = 360f;

    /// <summary>インターバル開始からの経過時間</summary>
    float currentTime;
    #endregion

    #region Methods  
    private void Awake()
    {
        Models = new List<Model>();

        // scene上に存在するモデルを全て検出し、その個数に応じてターンテーブルに等間隔で配置する
        ModelObjects = GameObject.FindGameObjectsWithTag("Model").ToList();
        float degree = 0f;
        ModelObjects.ForEach(model =>
        {
            degree += circumference / currentModelCount;
            Debug.Log(degree);
            model.transform.RotateAround(transform.position, Vector3.up, degree);
            // Scene上に存在するモデルからModelクラスを取得、対象モデルを適当に代入しておく
            Models.Add(model.GetComponent<Model>());
        });
        TargetModel = Models.First();
    }

    /// <summary>
    /// 隣のモデルが前面に来る様回転させる
    /// </summary>
    /// <param name="direction"></param>
    public void Rotation(Direction direction)
    {
        switch (direction)
        {
            case Direction.CounterClockwise:
                iTween.RotateAdd(gameObject, iTween.Hash("y", -(circumference / currentModelCount)));
                break;
            case Direction.Clockwise:
                iTween.RotateAdd(gameObject, iTween.Hash("y", (circumference / currentModelCount)));
                break;
            default:
                break;
        }
        OnTurn();
        Invoke("DelayEventCall", 0.5f);
    }

    void DelayEventCall()
    {
        DelayOnTurnEvent();
    }

    /// <summary>
    /// オート機能がOnになっている間は設定したインターバルが過ぎた時次のキャラクター迄回転させる
    /// </summary>
    private void Update()
    {
        // cameraとモデルの距離が一番短いモデルを対象にする
        Models.ForEach(model =>
        {
            if (TargetModel.DistanceToCamera > model.DistanceToCamera)
            {
                TargetModel = model;
            }
        });

        // 以下はauto機能onの時自動でターンテーブルを動かす記述
        if (!Toggle)
        {
            currentTime = 0f;
            return;
        }

        currentTime += Time.deltaTime;
        if (currentTime >= autoTurnInterval)
        {
            Rotation(Direction.Clockwise);
            currentTime = 0f;
        }
    }
    #endregion

    /// <summary>
    /// turnさせる向き
    /// </summary>
    public enum Direction
    {
        CounterClockwise,
        Clockwise,
    }
}
