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
		draw_sprite_ext(sui_heart, 0, _itemDx - 10 + 7, _itemDy - 24,
						1.0, 1.0, 0.0, c_white, _itemDalpha);

		draw_set_alpha(_itemDalpha);
		var l_colorRedBright = make_color_rgb(239, 58, 12);
		var l_colorRedHighlight = make_color_rgb(239, 183, 117);
		draw_set_font(f_04b03);
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
		draw_set_color(l_colorRedBright);
		draw_text(_itemDx - 5 + 7, _itemDy - 27, string(l_healthValue));
	}
}

return 0;