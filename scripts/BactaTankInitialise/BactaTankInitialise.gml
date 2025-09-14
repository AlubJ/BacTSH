/*
	BactaTankInitialise
	-------------------------------------------------------------------------
	Script:			BactaTankInitialise
	Version:		v1.00
	Created:		15/11/2024 by Alun Jones
	Description:	Initialise BactaTank
	-------------------------------------------------------------------------
	History:
	 - Created 15/11/2024 by Alun Jones
	
	To Do:
	 - Add more shader flags (fullbright, fulldark)
*/

// Model Version
enum BTModelVersion
{
	pcghgNU20Last,
	pcghgNU20First,
	none,
}
global.__modelVersion = ["PCGHG_NU20_LAST", "PCGHG_NU20_FIRST"];
#macro BT_MODEL_VERSION global.__modelVersion
	
// Model Vertex Attributes
enum BTVertexAttributes
{
	position,
	normal,
	tangent,
	bitangent,
	colour,
	colour2,
	uv,
	blendIndices,
	blendWeights,
	lightDirection,
	lightColour,
}
global.__attributes = ["Position", "Normal", "Tangent", "BiTangent", "Colour", "Colour2", "UV", "BlendIndices", "BlendWeights", "LightDirection", "LightColour"];
#macro BT_VERTEX_ATTRIBUTES global.__attributes

// Model Vertex Attributes
enum BTVertexAttributeTypes
{
	float2,
	float3,
	byte4,
	half2,
}
global.__attributeTypes = ["Float 2", "Float 3", "Byte 4", "Half 2"];
#macro BT_VERTEX_ATTRIBUTE_TYPES global.__attributeTypes

// DXT Compressions
global.DXTCompression = ["", "DXT1", "", "", "DXT3", "", "DXT5"];
#macro BT_DXT_COMPRESSION global.DXTCompression

// Shader Settings
//#macro bactatankShaderLightDirection			shader_get_uniform(defaultShading, "lightDirection")
//#macro bactatankShaderLightColour				shader_get_uniform(defaultShading, "lightColour")
//#macro bactatankShaderBlendColour				shader_get_uniform(defaultShading, "colour")
//#macro bactatankShaderInvView					shader_get_uniform(defaultShading, "invView")
//#macro bactatankShaderShiny						shader_get_uniform(defaultShading, "shiny")
//#macro bactatankShaderReflective				shader_get_uniform(defaultShading, "reflective")
//#macro bactatankShaderUseTexture				shader_get_uniform(defaultShading, "useTexture")
//#macro bactatankShaderUseLighting				shader_get_uniform(defaultShading, "useLighting")
//#macro bactatankShaderUseNormalMap				shader_get_uniform(defaultShading, "useNormalMap")
//#macro bactatankShaderTransparency				shader_get_uniform(defaultShading, "useTransparency")
//#macro bactatankShaderNormalMap					shader_get_sampler_index(defaultShading, "normalMap")
//#macro bactatankShaderCubeMap0					shader_get_sampler_index(defaultShading, "cubeMap0")
//#macro bactatankShaderCubeMap1					shader_get_sampler_index(defaultShading, "cubeMap1")
//#macro bactatankShaderAmbientColour				shader_get_uniform(renderShader, "ambientColour")

// Main Vertex Format
vertex_format_begin();
vertex_format_add_custom(vertex_type_float3, vertex_usage_position);
vertex_format_add_custom(vertex_type_float3, vertex_usage_normal);
vertex_format_add_custom(vertex_type_float2, vertex_usage_texcoord);
vertex_format_add_colour();
vertex_format_add_custom(vertex_type_float2, vertex_usage_texcoord);
global.vertexFormat = vertex_format_end();
#macro BT_VERTEX_FORMAT global.vertexFormat

// Grid Vertex Format
vertex_format_begin();
vertex_format_add_position_3d();
global.gridVertexFormat = vertex_format_end();
#macro BT_GRID_VERTEX_FORMAT global.gridVertexFormat

// UV Vertex Format
vertex_format_begin();
vertex_format_add_texcoord();
global.uvVertexFormat = vertex_format_end();
#macro BT_UV_VERTEX_FORMAT global.uvVertexFormat

enum BTAlphaBlend {
	none,
	transparent,
	cullClockwise				= 1 << 12,
	noCulling					= 1 << 13,
}

enum BTShaderFlags {
	useNormalMap				= 1 << 0,
	specularHighlighting		= 1 << 3,
	metallic					= 1 << 4,
	reflective					= 1 << 5,
	refraction					= 1 << 10, // Static Only
	noLighting					= 1 << 12,
	useShine					= 1 << 15,
}

// Shader Enum
enum BTShader
{
	vertex,
	fragment,
}

// DBGOUT
DBGOUT("BactaTank Classic: Initialised");