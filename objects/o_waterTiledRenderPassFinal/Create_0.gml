/// @description set up shader nonsense

/*

// Texel size of the screen
uniform vec2 uBufferTexelSize;
// Current time
uniform float uCurrentTime;

// Sampler for the water color lookup.
// Input needed is the 4 color palette for the edge, deep, middle, and highlights.
uniform sampler2D samplerPaletteLUT;
uniform vec4 uPaletteLUTAtlas;
// Sampler for the water density map
uniform sampler2D samplerDensity;
// Sampler for the caustics map
uniform sampler2D samplerCaustics;
uniform vec4 uCausticsAtlas;
// Sampler for the peturb map
uniform sampler2D samplerPeturb;
uniform vec4 uPeturbAtlas;

*/

m_shader = sh_tiledWater3;
uBufferTexelSize = shader_get_uniform(m_shader, "uBufferTexelSize");
uCurrentTime = shader_get_uniform(m_shader, "uCurrentTime");

samplerPaletteLUT = shader_get_sampler_index(m_shader, "samplerPaletteLUT");
uPaletteLUTAtlas = shader_get_uniform(m_shader, "uPaletteLUTAtlas");

samplerDensity = shader_get_sampler_index(m_shader, "samplerDensity");
//uPaletteLUTAtlas = shader_get_uniform(m_shader, "uPaletteLUTAtlas");

samplerDensityBlurred = shader_get_sampler_index(m_shader, "samplerDensityBlurred");

samplerCaustics = shader_get_sampler_index(m_shader, "samplerCaustics");
uCausticsAtlas = shader_get_uniform(m_shader, "uCausticsAtlas");

samplerPeturb = shader_get_sampler_index(m_shader, "samplerPeturb");
uPeturbAtlas = shader_get_uniform(m_shader, "uPeturbAtlas");


surface_tilemapComposite = null;//surface_create(Screen.width, Screen.height);
surface_tilemapCompositeBlur = null;

uBlurPixelInfo = shader_get_uniform(sh_7tapBlurFilter, "uBlurPixelInfo");

