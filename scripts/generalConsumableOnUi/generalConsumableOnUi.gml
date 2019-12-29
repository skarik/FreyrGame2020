var _itemType = argument0;
var _itemDx = argument1;
var _itemDy = argument2;
var _itemDalpha = argument3;
var _itemIsSelected = argument4;
var _itemUiCategory = argument5;

if (_itemIsSelected && _itemUiCategory == kItemUiCategoryBelt)
{
	var l_drawHealth = false;
	var l_healthValue = 0.0;
	
	if (_itemType == o_pickupCons_Berries)
	{
		l_drawHealth = true;
		l_healthValue = 2;
	}
	if (_itemType == o_pickupCons_Nuts)
	{
		l_drawHealth = true;
		l_healthValue = 3;
	}
	if (_itemType == o_pickupCons_Meats)
	{
		l_drawHealth = true;
		l_healthValue = 3;
	}
	
	if (l_drawHealth)
	{
		draw_sprite_ext(sui_heart, 0, _itemDx - 10 + 6, _itemDy - 16,
						1.0, 1.0, 0.0, c_white, _itemDalpha);

		var l_colorRedBright = make_color_rgb(239, 58, 12);
		var l_colorRedHighlight = make_color_rgb(239, 183, 117);
		{
			var l_textSurface = surface_create(32, 16);
			surface_set_target(l_textSurface);
			// Clear to transparent first
			draw_clear_alpha(c_black, 0.0);
	
			draw_set_font(f_04b03);
			draw_set_halign(fa_left);
			draw_set_valign(fa_top);
			draw_set_alpha(1.0);
	
			// First, draw the highlight
			draw_set_color(l_colorRedHighlight);
			draw_text(0, 0, string(l_healthValue));
			  
			// Mask out the highlight
			gpu_set_blendmode_ext_sepalpha(bm_zero, bm_zero, bm_zero, bm_zero);
			draw_rectangle(0, 3, 32, 32, false);
	
			// Third, draw the other color
			gpu_set_blendmode_ext(bm_inv_dest_alpha, bm_one);
			draw_set_color(l_colorRedBright);
			draw_text(0, 0, string(l_healthValue));
			  
			// Reset drawing mode
			gpu_set_blendmode(bm_normal);
			draw_set_color(c_white);
			surface_reset_target();
	
			// draw the text surface
			draw_surface_ext(l_textSurface, _itemDx - 5 + 6, _itemDy - 19,
							 1.0, 1.0, 0.0, c_white, _itemDalpha);
	
			// no longer need the text surface
			surface_free(l_textSurface);
		}
	}
}

return 0;