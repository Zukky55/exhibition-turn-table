using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

/// <summary>
/// Modelの情報を保存するクラス
/// </summary>
public class Model : MonoBehaviour
{

    /// <summary>カメラからの距離</summary>
    public float DistanceToCamera
    {
        get
        {
            return Vector3.Distance(camera.position, transform.position);
        }
    }

    /// <summary>キャプションテキスト</summary>
    [SerializeField]
    [Multiline(5)]
    public string CaptionText;

    /// <summary>そのモデルの適切なカメラ位置</summary>
    [SerializeField]
    public Vector3 ProperCameraPosition;

    /// <summary>背景色</summary>
    [SerializeField] public Color backgroundColor;

    /// <summary>DirectionalLightの方向ベクトル</summary>
    [SerializeField] public Vector3 LightVector;

    /// <summary>メインカメラのtransform</summary>
    Transform camera;

    private void Awake()
    {
        // メインカメラのtransformを取得
        camera = Camera.main.transform;
    }
}
