using System.Runtime.CompilerServices;
using UnityEngine;

public class Balareal : MonoBehaviour
{
    public float Speed;

    private Rigidbody2D Rigidbody2D;
    private Vector2 Direction;

    void Start()
    {
        Rigidbody2D = GetComponent<Rigidbody2D>();
        
    }


   private void FixedUpdate()
    {
        Rigidbody2D.linearVelocity=  Direction * Speed;
    }

    public void SetDirection (Vector2 direction)
    {
        Direction = direction;  
    }

    public void DestroyBalareal() 
    {
        Destroy (gameObject);
    }
}
