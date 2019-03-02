using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TurnTable : MonoBehaviour
{
    [SerializeField] float turnSpeed;

    private void Update()
    {
        
    }

    public void Rotation(Direction dir)
    {
        switch (dir)
        {
            case Direction.Left:
                break;
            case Direction.Right:
                break;
            default:
                break;
        }
    }

    public enum Direction
    {
        Left,
        Right,
    }
}
