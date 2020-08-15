// TODO DRAW WILL

var _itemType = argument0;
var _itemDx = argument1;
var _itemDy = argument2;
var _itemDalpha = argument3;
var _itemIsSelected = argument4;
var _itemUiCategory = argument5;

if (_itemIsSelected
	&& (_itemUiCategory == kItemUiCategoryBelt
		|| _itemUiCategory == kItemUiCategoryInspect))
{
	var l_drawHealth = false;
	var l_drawWill = false;
	
	var l_healthValue = 0;
	var l_willValue = 0;
	
	switch(_itemType)
	{
		
			//NON-CRAFTED
		
		case o_pickupCons_Berries:
			l_drawHealth = true;
			l_healthValue = 2;
			break;
		case o_pickupCons_MedLeaf:
			l_drawHealth = true;
			l_healthValue = 5;
			break;
		case o_pickupCons_Nuts:
			l_drawHealth = true;
			l_healthValue = 2;
			break;
		case o_pickupCons_Meats:
			l_drawHealth = true;
			l_healthValue = 3;
			break;
				
			//CRAFTED
			
			//DRINKS
			
		case o_pickupCons_FermPotion:
			l_drawHealth = true;
			l_healthValue = 4;
			break;
		case o_pickupCons_CactusRed:
			l_drawHealth = true;
			l_healthValue = -5;
			l_drawWill = true;
			l_willValue = 1 * 60;
			break;
		case o_pickupCons_HoneyAbsinthe:
			l_drawHealth = true;
			l_healthValue = -3;
			l_drawWill = true;
			l_willValue = 1 * 40;
			break;
		case o_pickupCons_CactusJizz:
			l_drawHealth = true;
			l_healthValue = -7;
			l_drawWill = true;
			l_willValue = 1 * 90;
			break;
		case o_pickupCons_ScorpJuice:
			l_drawHealth = true;
			l_healthValue = 3;
			break;
			
			//FOOD
			
		case o_pickupCons_RiceBalls:
			l_drawHealth = true;
			l_healthValue = 2;
			break;
		case o_pickupCons_SweetBun:
			l_drawHealth = true;
			l_healthValue = 4;
			break;
		case o_pickupCons_StuffedBun:
			l_drawHealth = true;
			l_healthValue = 5;
			break;
		case o_pickupCons_RedCroiss:
			l_drawHealth = true;
			l_healthValue = 3;
			break;
		case o_pickupCons_MithranCheese:
			l_drawHealth = true;
			l_healthValue = 4;
			break;
		case o_pickupCons_ScorpStick:
			l_drawHealth = true;
			l_healthValue = 3;
			break;
	}

	var l_colorRedBright = make_color_rgb(239, 58, 12);
	var l_colorRedHighlight = make_color_rgb(239, 183, 117);

	if (_itemUiCategory == kItemUiCategoryBelt)
	{
		var l_penY = _itemDy - 17;
		if (l_drawWill)
		{
			draw_sprite_ext(sui_willdiamond, 0, _itemDx - 10 + 2, l_penY,
							1.0, 1.0, 0.0, c_white, _itemDalpha);
			{
				var l_textSurface = surface_create(32, 16);
				surface_set_target(l_textSurface);
				// Clear to transparent first
				draw_clear_alpha(c_black, 0.0);
	
				draw_set_font(f_04b03);
				draw_set_halign(fa_left);
				draw_set_valign(fa_top);
				draw_set_alpha(1.0);
	
				var text_string = string(round(l_willValue / 60)) + " hr.";
	
				// First, draw the highlight
				draw_set_color(c_gold);
				draw_text(0, 0, text_string);
			  
				// Mask out the highlight
				gpu_set_blendmode_ext_sepalpha(bm_zero, bm_zero, bm_zero, bm_zero);
				draw_rectangle(0, 3, 32, 32, false);
	
				// Third, draw the other color
				gpu_set_blendmode_ext(bm_inv_dest_alpha, bm_one);
				draw_set_color(c_uigold);
				draw_text(0, 0, text_string);
			  
				// Reset drawing mode
				gpu_set_blendmode(bm_normal);
				draw_set_color(c_white);
				surface_reset_target();
	
				// draw the text surface
				draw_surface_ext(l_textSurface, _itemDx - 5 + 2, l_penY - 3,
								 1.0, 1.0, 0.0, c_white, _itemDalpha);
	
				// no longer need the text surface
				surface_free(l_textSurface);
			}
			
			l_penY -= 9;
		}
		if (l_drawHealth)
		{
			draw_sprite_ext(sui_heart, 0, _itemDx - 10 + 6, l_penY,
							1.0, 1.0, 0.0, c_white, _itemDalpha);
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
				draw_surface_ext(l_textSurface, _itemDx - 5 + 6, l_penY - 3,
								 1.0, 1.0, 0.0, c_white, _itemDalpha);
	
				// no longer need the text surface
				surface_free(l_textSurface);
			}
			
			l_penY -= 9;
		}
	}
	else if (_itemUiCategory == kItemUiCategoryInspect)
	{
		var l_penX = _itemDx;
		if (l_drawHealth)
		{
			draw_sprite_ext(sui_statIcons, 0, l_penX, _itemDy + 2,
							1.0, 1.0, 0.0, c_white, _itemDalpha);
			
			draw_set_color(l_colorRedBright);
			draw_set_alpha(1.0);
			
			draw_set_font(global.font_arvo7);
			draw_set_halign(fa_left);
			draw_set_valign(fa_top);

			draw_text_spaced(l_penX + 11, _itemDy, string(l_healthValue), 2);
			
			l_penX += 30;
		}
		if (l_drawWill)
		{
			draw_sprite_ext(sui_statIcons, 1, l_penX, _itemDy + 2,
							1.0, 1.0, 0.0, c_white, _itemDalpha);
			
			draw_set_color(c_uigold);
			draw_set_alpha(1.0);
			
			draw_set_font(global.font_arvo7);
			draw_set_halign(fa_left);
			draw_set_valign(fa_top);
			
			draw_text_spaced(l_penX + 11, _itemDy, string(round(l_willValue / 60)) + " hr.", 2);
			
			l_penX += 30;
		}
	}
}
		
return 0;