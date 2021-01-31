Shader "UI/StencilParentShader"
{
    SubShader {
        Tags { "RenderType"="Opaque" "Queue"="Transparent+1"}
        Blend SrcAlpha OneMinusSrcAlpha
        Pass {
            Stencil {
                Ref 2
                Comp notequal
            }
        }
    } 
}
