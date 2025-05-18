using UnityEngine;

public class CameraScript : MonoBehaviour
{

    public GameObject xlw;

    void Update()
    {
        Vector3 position = transform.position;
        position.x = xlw.transform.position.x;
        transform.position = position;
        
    }
}
