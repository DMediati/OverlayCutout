using UnityEngine;
using UnityEngine.UI;
public class InverseMaskImage : Image
{
    public override bool IsRaycastLocationValid(Vector2 sp, Camera eventCamera) {
        foreach(Transform child in transform) {
            if(!child.gameObject.activeInHierarchy)
                continue;

            RectTransform childRect = child.GetComponent<RectTransform>();
            if(childRect != null) {
                if(RectTransformUtility.RectangleContainsScreenPoint(childRect, sp, eventCamera)) {
                    return false;
                }
            }
        }
        return true;
    }
}

