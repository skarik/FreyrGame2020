//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec4 u_spriteCoords; // x: left, y: top, z: right, w: bottom
uniform vec2 u_spriteTexelCount;
uniform vec4 u_animationValues;

void main()
{
	// Grab the base color
	vec4 l_baseColor = texture2D( gm_BaseTexture, v_vTexcoord );
	
	// Generate the correct coordinates across the atlas
	vec2 l_texCoord = v_vTexcoord;
	vec2 l_texCoordDelta = u_spriteCoords.zw - u_spriteCoords.xy;
	vec2 l_texelSize = l_texCoordDelta / u_spriteTexelCount;
	
	vec2 l_texCoordNormalized = (v_vTexcoord - u_spriteCoords.xy) / l_texCoordDelta;
	
	// Set up the sway
	float l_swayVertical = (1.0 - l_texCoordNormalized.y);
	/*float l_swayColor = 1.5 - min(
		length(l_baseColor.rgb - vec3(0.647, 0.549, 0.153)), // Base green
		length(l_baseColor.rgb - vec3(0.235, 0.624, 0.611))  // Oasis green
		) * 3.0;*/
	float l_swayColor = (l_baseColor.g / (l_baseColor.r + l_baseColor.b)) * 2.0;
		l_swayColor = (l_swayColor - 1.0) * 20.0;
		l_swayColor = max(l_swayColor, 1.0 - l_baseColor.a);
	float l_swayAmount = 1.4;
	
	// Offset coord for the sway
	l_texCoord.x +=
		//sin(u_animationValues.x * 3.0 + (l_texCoordNormalized.y * u_spriteTexelCount.y * 0.1))
		(sin(u_animationValues.w + u_animationValues.x * 1.2 + (l_texCoordNormalized.y * 2.3))
		    + sin(u_animationValues.w + u_animationValues.x * 2.1 + (l_texCoordNormalized.y * u_spriteTexelCount.y * 0.2))
		    * 0.5)
		* l_texelSize.x
		* l_swayAmount
		* l_swayVertical
		* clamp(l_swayColor, 0.0, 1.0);
	l_texCoord.y +=
		(sin(u_animationValues.w + u_animationValues.x * 2.3 + 0.6 * (l_texCoordNormalized.x * u_spriteTexelCount.x * 0.21))
		    + sin(u_animationValues.w - u_animationValues.x * 1.7 + 0.6 * (l_texCoordNormalized.x * u_spriteTexelCount.x * 0.37))
			)
		* l_texelSize.y
		* l_swayAmount
		* l_swayVertical
		* clamp(l_swayColor, 0.0, 1.0)
		* 0.5;
		
	// Limit coord at the edges
	l_texCoord.x = clamp(l_texCoord.x, u_spriteCoords.x, u_spriteCoords.z);
	l_texCoord.y = clamp(l_texCoord.y, u_spriteCoords.y, u_spriteCoords.w);
	
    gl_FragColor = v_vColour * texture2D( gm_BaseTexture, l_texCoord );
	if (gl_FragColor.a < 0.5)
		discard;
	
	//gl_FragColor.rgb = vec3(v_vTexcoord.xy, 0.0);
}
