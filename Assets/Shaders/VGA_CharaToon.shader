// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "VGA/TN/VGA_CharaToon"
{
	Properties
	{
		_MainTex("MainTex", 2D) = "white" {}
		_ShadowTex("ShadowTex", 2D) = "white" {}
		_NormalMap("NormalMap", 2D) = "bump" {}
		_Emission("Emission", 2D) = "black" {}
		_Specular("Specular", 2D) = "black" {}
		_ForceShadow("ForceShadow", 2D) = "white" {}
		_shadowColor("shadowColor", Color) = (0.6618013,0.7719153,0.9811321,1)
		_shadowLine("shadowLine", Range( 0 , 1)) = 0
		_ambientAmount("ambientAmount", Range( 0 , 1)) = 0
		_ShadowJitter("ShadowJitter", Range( 0 , 1)) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Off
		ZWrite On
		Blend SrcAlpha OneMinusSrcAlpha
		
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#include "UnityCG.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha 
		struct Input
		{
			float2 uv_texcoord;
			float3 worldPos;
			float3 worldNormal;
			INTERNAL_DATA
		};

		uniform sampler2D _NormalMap;
		uniform float4 _NormalMap_ST;
		uniform sampler2D _ShadowTex;
		uniform float4 _ShadowTex_ST;
		uniform float _ambientAmount;
		uniform float4 _shadowColor;
		uniform sampler2D _MainTex;
		uniform float4 _MainTex_ST;
		uniform float _shadowLine;
		uniform float _ShadowJitter;
		uniform sampler2D _ForceShadow;
		uniform float4 _ForceShadow_ST;
		uniform sampler2D _Specular;
		uniform float4 _Specular_ST;
		uniform sampler2D _Emission;
		uniform float4 _Emission_ST;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_NormalMap = i.uv_texcoord * _NormalMap_ST.xy + _NormalMap_ST.zw;
			o.Normal = UnpackNormal( tex2D( _NormalMap, uv_NormalMap ) );
			float4 color58 = IsGammaSpace() ? float4(0,0,0,0) : float4(0,0,0,0);
			o.Albedo = color58.rgb;
			#if defined(LIGHTMAP_ON) && UNITY_VERSION < 560 //aselc
			float4 ase_lightColor = 0;
			#else //aselc
			float4 ase_lightColor = _LightColor0;
			#endif //aselc
			float2 uv_ShadowTex = i.uv_texcoord * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
			float2 uv_MainTex = i.uv_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
			float4 tex2DNode1 = tex2D( _MainTex, uv_MainTex );
			float3 ase_worldPos = i.worldPos;
			#if defined(LIGHTMAP_ON) && UNITY_VERSION < 560 //aseld
			float3 ase_worldlightDir = 0;
			#else //aseld
			float3 ase_worldlightDir = normalize( UnityWorldSpaceLightDir( ase_worldPos ) );
			#endif //aseld
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float dotResult5 = dot( ase_worldlightDir , ase_worldNormal );
			float temp_output_39_0 = saturate( dotResult5 );
			float temp_output_19_0 = ( _ShadowJitter / 2.0 );
			float2 uv_ForceShadow = i.uv_texcoord * _ForceShadow_ST.xy + _ForceShadow_ST.zw;
			float temp_output_44_0 = min( saturate( (0.0 + (temp_output_39_0 - max( 0.0 , ( _shadowLine - temp_output_19_0 ) )) * (1.0 - 0.0) / (min( ( _shadowLine + temp_output_19_0 ) , 1.0 ) - max( 0.0 , ( _shadowLine - temp_output_19_0 ) ))) ) , tex2D( _ForceShadow, uv_ForceShadow ).r );
			float4 lerpResult8 = lerp( ( tex2D( _ShadowTex, uv_ShadowTex ) * ( 1.0 - ( ( 1.0 - UNITY_LIGHTMODEL_AMBIENT ) * _ambientAmount ) ) * _shadowColor ) , tex2DNode1 , temp_output_44_0);
			float2 uv_Specular = i.uv_texcoord * _Specular_ST.xy + _Specular_ST.zw;
			float4 lerpResult47 = lerp( float4( (float4(0,0,0,0)).rgb , 0.0 ) , ( tex2D( _Specular, uv_Specular, float2( 0,0 ), float2( 0,0 ) ) * ( 1.0 - temp_output_39_0 ) ) , temp_output_44_0);
			float2 uv_Emission = i.uv_texcoord * _Emission_ST.xy + _Emission_ST.zw;
			o.Emission = ( ( float4( ase_lightColor.rgb , 0.0 ) * ( saturate( lerpResult8 ) + lerpResult47 ) ) + tex2D( _Emission, uv_Emission ) ).rgb;
			o.Alpha = tex2DNode1.a;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16200
343;657;1458;559;32.61589;431.1316;1.823352;True;True
Node;AmplifyShaderEditor.RangedFloatNode;20;-1579.99,636.1478;Half;False;Constant;_Float2;Float 2;3;0;Create;True;0;0;False;0;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;10;-1771.807,516.968;Float;False;Property;_ShadowJitter;ShadowJitter;10;0;Create;True;0;0;False;0;0;0.18;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.WorldNormalVector;4;-1842.706,77.30542;Float;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WorldSpaceLightDirHlpNode;2;-1894.045,-146.8818;Float;False;False;1;0;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleDivideOpNode;19;-1370.058,547.0559;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;9;-1779.25,423.8541;Float;False;Property;_shadowLine;shadowLine;8;0;Create;True;0;0;False;0;0;0.3;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;22;-1248.702,339.4645;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;25;-1279.121,249.5867;Float;False;Constant;_Float3;Float 3;3;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;29;-1222.634,625.5367;Float;False;Constant;_Float4;Float 4;3;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;21;-1179.771,474.0192;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;5;-1539.656,-44.60488;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FogAndAmbientColorsNode;6;-1240.954,-184.9281;Float;False;UNITY_LIGHTMODEL_AMBIENT;0;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMinOpNode;27;-981.582,437.7232;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;14;-711.8545,652.524;Float;False;Constant;_Float1;Float 1;1;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;28;-980.1033,317.9367;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;39;-1369.883,-43.81231;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;13;-818.0046,579.3849;Float;False;Constant;_Float0;Float 0;1;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;51;-900.7886,-45.84375;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;50;-1093.789,330.1563;Float;False;Property;_ambientAmount;ambientAmount;9;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;52;-709.7886,9.15625;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.TFHCRemapNode;12;-546.2712,258.1449;Float;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;46;-678.8708,-231.2705;Float;True;Property;_ShadowTex;ShadowTex;1;0;Create;True;0;0;False;0;None;374de83ec47dceb4dab5eb6327ad4acf;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;16;-269.718,262.1465;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;43;-381.1129,438.3249;Float;True;Property;_ForceShadow;ForceShadow;6;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;53;-537.7886,12.15625;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;35;-888.9152,128.5591;Float;False;Property;_shadowColor;shadowColor;7;0;Create;True;0;0;False;0;0.6618013,0.7719153,0.9811321,1;0.6699825,0.6503649,0.745283,1;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;31;-700.7646,-601.759;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;18;184.1929,417.4144;Float;False;Constant;_Color0;Color 0;3;0;Create;True;0;0;False;0;0,0,0,0;0,0,0,0;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;7;-216.5221,5.304626;Float;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;1;-627.1425,-476.8921;Float;True;Property;_MainTex;MainTex;0;0;Create;True;0;0;False;0;None;819da5a670ca1274393f59ed299b9f9d;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;30;-755.4097,-814.5342;Float;True;Property;_Specular;Specular;5;0;Create;True;0;0;False;0;None;None;True;0;False;black;Auto;False;Object;-1;Derivative;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMinOpNode;44;-12.29583,264.845;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;8;72.81219,-157.9734;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ComponentMaskNode;48;423.5388,67.02139;Float;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;40;-96.33452,-492.9637;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;37;633.436,-160.8643;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;47;729.5709,68.13748;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LightColorNode;41;760.2936,-315.2881;Float;False;0;3;COLOR;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleAddOpNode;32;905.1688,-165.6441;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;42;1176.193,-242.7529;Float;False;2;2;0;FLOAT3;0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;45;1053.999,-22.82789;Float;True;Property;_Emission;Emission;4;0;Create;True;0;0;False;0;None;None;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;55;1502.942,22.0592;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;54;1029.179,-489.5514;Float;True;Property;_NormalMap;NormalMap;3;0;Create;True;0;0;False;0;None;None;True;0;False;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;26;-1024.469,671.3806;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RelayNode;49;868.6807,417.0217;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;58;1441.581,-178.5008;Float;False;Constant;_Color1;Color 1;11;0;Create;True;0;0;False;0;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1800.378,-176.2039;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;VGA/TN/VGA_CharaToon;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;Off;1;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Transparent;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;2;5;False;-1;10;False;-1;0;5;False;-1;10;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;2;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;19;0;10;0
WireConnection;19;1;20;0
WireConnection;22;0;9;0
WireConnection;22;1;19;0
WireConnection;21;0;9;0
WireConnection;21;1;19;0
WireConnection;5;0;2;0
WireConnection;5;1;4;0
WireConnection;27;0;21;0
WireConnection;27;1;29;0
WireConnection;28;0;25;0
WireConnection;28;1;22;0
WireConnection;39;0;5;0
WireConnection;51;0;6;0
WireConnection;52;0;51;0
WireConnection;52;1;50;0
WireConnection;12;0;39;0
WireConnection;12;1;28;0
WireConnection;12;2;27;0
WireConnection;12;3;13;0
WireConnection;12;4;14;0
WireConnection;16;0;12;0
WireConnection;53;0;52;0
WireConnection;31;0;39;0
WireConnection;7;0;46;0
WireConnection;7;1;53;0
WireConnection;7;2;35;0
WireConnection;44;0;16;0
WireConnection;44;1;43;1
WireConnection;8;0;7;0
WireConnection;8;1;1;0
WireConnection;8;2;44;0
WireConnection;48;0;18;0
WireConnection;40;0;30;0
WireConnection;40;1;31;0
WireConnection;37;0;8;0
WireConnection;47;0;48;0
WireConnection;47;1;40;0
WireConnection;47;2;44;0
WireConnection;32;0;37;0
WireConnection;32;1;47;0
WireConnection;42;0;41;1
WireConnection;42;1;32;0
WireConnection;55;0;42;0
WireConnection;55;1;45;0
WireConnection;49;0;1;4
WireConnection;0;0;58;0
WireConnection;0;1;54;0
WireConnection;0;2;55;0
WireConnection;0;9;49;0
ASEEND*/
//CHKSM=294084C172AF9C24B7F59108B87CBB23F5579EC5