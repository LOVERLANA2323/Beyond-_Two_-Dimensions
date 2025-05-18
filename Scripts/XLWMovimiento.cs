using UnityEngine;
using UnityEngine.InputSystem;
using UnityEngine.Rendering;

public class XLWMovimiento : MonoBehaviour
{
    public GameObject Balarealprefab;
    public float Speed;
    public float JumpForce;
   

    private Rigidbody2D Rigidbody2D;
    private Animator Animator;
    private float Horizontal;
    private float LastShoot;




    void Start()
    {
        Rigidbody2D = GetComponent<Rigidbody2D>();
        Animator = GetComponent<Animator>();
    }

    void Update()
    {
        // Nuevo sistema de input
        Horizontal = Keyboard.current.aKey.isPressed ? -1 :
                     Keyboard.current.dKey.isPressed ? 1 : 0;

  

        Animator.SetBool("Running", Horizontal != 0.0f);


        if (Keyboard.current.wKey.wasPressedThisFrame )
        {
            Jump();
        }

        if (Keyboard.current.eKey.wasPressedThisFrame && Time.time > LastShoot + 0.2)
       {
            Shoot();
            LastShoot = Time.time;
          }
    }

    private void FixedUpdate()
    { 
        Rigidbody2D.linearVelocity = new Vector2(Horizontal * Speed, Rigidbody2D.linearVelocity.y);
    }

    
    private void Jump()
    {
        Rigidbody2D.linearVelocity = new Vector2(Rigidbody2D.linearVelocity.x, JumpForce);
    }

  

    private void Shoot()
    {
        Vector3 direction;
       if(transform.localScale.x== 0.1f) direction = Vector2.left;
        else direction  = Vector2.right; 

            GameObject Balareal = Instantiate(Balarealprefab, transform.position  + direction   * 0.1f, Quaternion.identity);
        Balareal.GetComponent<Balareal>().SetDirection(direction);
    }
}
    

