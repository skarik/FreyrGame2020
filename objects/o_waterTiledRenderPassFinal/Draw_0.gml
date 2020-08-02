/// @description Draw water in one go

/*
gpu_set_blendmode_ext(bm_inv_dest_alpha, bm_dest_alpha);
draw_set_color(merge_color(c_black,c_crystalblue,0.5));
draw_set_alpha(1.0);
draw_rectangle(0, 0, room_width, room_height, false);
gpu_set_blendmode(bm_normal);

debugOut(string(application_surface) + " : " + string(Screen.m_gameSurface))*/

gpu_set_alphatestenable(false);

var game_surface = view_get_surface_id(0);
if (!surface_exists(game_surface))
	exit;
	
//debugOut(string(game_surface) + " : " + string(Screen.m_gameSurface))

var water_surface = surface_create(surface_get_width(game_surface), surface_get_height(game_surface));
surface_set_target(water_surface);
	gpu_set_blendmode_ext(bm_one, bm_zero);
	draw_clear_alpha(c_black, 0.0);
	draw_surface(game_surface, 0, 0);
	gpu_set_blendmode(bm_normal);
surface_reset_target();

shader_set(sh_tiledWater3);

	// Set up blend state
	gpu_set_blendmode(bm_normal);

	// Get texture information
	var texturePaletteLut = sprite_get_texture(s_paletteWater, 0);
	var texturePaletteLutCoords = sprite_get_uvs(s_paletteWater, 0);
	var textureCaustics = sprite_get_texture(s_waterOverlayCaustic, 0);
	var textureCausticsCoords = sprite_get_uvs(s_waterOverlayCaustic, 0);
	var textureDensity = surface_get_texture(surface_tilemapComposite);
	var textureDensityBlurred = surface_get_texture(surface_tilemapCompositeBlur);
	
	// Set up the shader
	shader_set_uniform_f(uBufferTexelSize,
		1.0 / surface_get_width(game_surface),
		1.0 / surface_get_height(game_surface));
	shader_set_uniform_f(uCurrentTime, Time.time);

	texture_set_stage(samplerPaletteLUT, texturePaletteLut);
	shader_set_uniform_f(uPaletteLUTAtlas,
		texturePaletteLutCoords[0], texturePaletteLutCoords[1],
		texturePaletteLutCoords[2] - texturePaletteLutCoords[0],
		texturePaletteLutCoords[3] - texturePaletteLutCoords[1]);

	texture_set_stage(samplerCaustics, textureCaustics);
	shader_set_uniform_f(uCausticsAtlas,
		textureCausticsCoords[0], textureCausticsCoords[1],
		textureCausticsCoords[2] - textureCausticsCoords[0],
		textureCausticsCoords[3] - textureCausticsCoords[1]);
		
	texture_set_stage(samplerDensity, textureDensity);
	texture_set_stage(samplerDensityBlurred, textureDensityBlurred);

	draw_surface(water_surface, GameCamera.view_x, GameCamera.view_y);
shader_reset();

surface_free(water_surface);