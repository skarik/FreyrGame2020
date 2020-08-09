
global.sh_hq2x_surface = null;

global.sh_hq2x_u_spriteSize = shader_get_uniform(sh_hqx2, "u_spriteSize");
global.sh_hq2x_u_spriteUVs = shader_get_uniform(sh_hqx2, "u_spriteUVs");
global.sh_hq2x_samplerHQXLut = shader_get_sampler_index(sh_hqx2, "samplerHQXLut");

global.sh_advMame2x_u_spriteSize = shader_get_uniform(sh_advMame2x, "u_spriteSize");
global.sh_advMame2x_u_spriteUVs = shader_get_uniform(sh_advMame2x, "u_spriteUVs");