Shader "UI/StencilChildShader"
{
    Properties {
        [PerRendererData] _MainTex ("Sprite Texture", 2D) = "white" {}
    }
    SubShader {
        Tags { "Queue"="Transparent"}
        Blend Zero One
        Pass {
            Stencil {
                Ref 2
                Comp always
                Pass replace
            }
            //Using this is more expensive but gives more control over blending and doesn't need sprite mesh checked
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
     
            struct appdata_t
            {
                float4 vertex   : POSITION;
                float4 color    : COLOR;
                float2 texcoord : TEXCOORD0;
            };
 
            struct v2f
            {
                float4 vertex   : SV_POSITION;
                fixed4 color    : COLOR;
                half2 texcoord  : TEXCOORD0;
            };
 
            v2f vert(appdata_t IN)
            {
                v2f OUT;
                OUT.vertex = UnityObjectToClipPos(IN.vertex);
                OUT.texcoord = IN.texcoord;
                OUT.color = IN.color;
                return OUT;
            }
 
            sampler2D _MainTex;
 
            fixed4 frag(v2f IN) : SV_Target
            {
                fixed4 c = tex2D(_MainTex, IN.texcoord) * IN.color;
                if (c.a<0.1) discard; //Most IMPORTANT working Code
                c.rgb = 0;
                c.a = 0;
                return c;
            }
            ENDCG
        }
    } 
}
