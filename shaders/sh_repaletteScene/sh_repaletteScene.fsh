//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

// Input needed is the 3d lut sampler
uniform sampler2D samplerPaletteLUT;
uniform vec4 uLookupDivs;

void main()
{
	// Sample the scene normally
	vec4 color_scene	= texture2D( gm_BaseTexture, v_vTexcoord );
	
	// Perform the 3D lookup
	vec2 color_lookup_coords = vec2(
		color_scene.r * uLookupDivs.x + floor(color_scene.b * uLookupDivs.z) * uLookupDivs.w,
		color_scene.g); // * uLookupDivs.y
	vec4 color_lookup	= texture2D( samplerPaletteLUT, color_lookup_coords );
    gl_FragColor = color_lookup;//abs(color_lookup - color_scene);
	//gl_FragColor = v_vTexcoord.xyyy;
}
