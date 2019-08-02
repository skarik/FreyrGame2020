/// @description Set background positions

layer_x(foreground_overclouds, layer_get_x(foreground_overclouds) - 44 * Time.deltaTime);
layer_y(foreground_overclouds, 280 + GameCamera.view_y * -0.2);
//layer_background_xscale(layer_background_get_id(foreground_overclouds), -1.0);

layer_x(background_nearclouds, layer_get_x(background_nearclouds) + 35 * Time.deltaTime);
layer_y(background_nearclouds, 240 + GameCamera.view_y * 0.1);
layer_x(background_farclouds, layer_get_x(background_farclouds) - 12 * Time.deltaTime);
layer_y(background_farclouds, 220 + GameCamera.view_y * 0.2);
layer_y(background_horizon, 100 + GameCamera.view_y * 0.5);
layer_y(assets300, GameCamera.view_y * 0.75);

var sky_light;
sky_light = merge_color(make_color_rgb(0xFF, 0x76, 0x4C), make_color_rgb(0x89, 0xC6, 0xE5), o_dayNightCycle.m_blendSunsetToDay);
sky_light = merge_color(sky_light, make_color_rgb(9, 7, 26), o_dayNightCycle.m_blendSunsetToNight);
layer_background_blend(layer_background_get_id(background_sky), sky_light);
