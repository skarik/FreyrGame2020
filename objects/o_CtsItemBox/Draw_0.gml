
// Several stages:
// 1 - the item raises above the player
// 1.5 - lights fade in behind the item
// 2 - item moves to where the box is
// 2.5 - box fades in, gilded
// 3.0 - box background comes in
// 3.1 - box item name comes in
// 4.0 - box text comes in

//var suiChoiceBox = sui_choiceBox3Transparent;
var suiChoiceBox = sui_choiceBox;

var box_h = display_height;
var box_hw = display_width / 2;

var dx = uiPosX + display_width * 0.5;
var dy = uiPosY - box_h * 0.5;

// Fade in the back with alpha
if (image_alpha > 0.0)
{
	var box_xblend0 = saturate(lerp(0.0, 4.5, image_alpha));
	var box_yblend0 = saturate(lerp(-1.0, 3.5, image_alpha) * 0.5);
	var box_xblend1 = saturate(lerp(-3.0, 1.5, image_alpha));
	var box_glowblend = saturate(lerp(-4.0, 0.5, image_alpha) * 2.0);
	
	// Fade in the background
	var background_alpha = saturate(image_alpha * 2.0 - 0.4) * 0.6;
	draw_set_alpha(background_alpha);
	draw_set_color(c_black);
	draw_rectangle(dx - box_hw + 2, dy + 2, dx + box_hw - 3, dy + box_h - 3, false);
	draw_set_alpha(1.0);
	if (surface_exists(surface_shine_bg))
	{
		draw_surface_ext(surface_shine_bg,
						 dx - box_hw + 2, dy + 2,
						 1.0, 1.0,
						 0.0, c_white, background_alpha);
	}
	
	// Start with the left side
	draw_sprite_part_ext(suiChoiceBox, 0,	// draw top line
						 (1.0 - box_xblend0) * (box_hw - 4) + 4, 0,
						 box_xblend0 * (box_hw - 4), 20,
						 dx - box_xblend0 * (box_hw - 4), dy,
						 1.0, 1.0, c_white, 1.0);
	draw_sprite_part_ext(suiChoiceBox, 0,	// draw corner
						 0, 0,
						 box_hw, 20 * saturate(box_yblend0 * (box_h / 20)),
						 dx - box_hw, dy,
						 1.0, 1.0, c_white, 1.0);
	draw_sprite_part_ext(suiChoiceBox, 1,	// draw wall
						 0, 0,
						 box_hw, 20.0,
						 dx - box_hw, dy + 20,
						 1.0,
						 (1/20.0) * (box_h - 40) * saturate((box_yblend0 - (20 / box_h)) * (box_h / (box_h - 40))),
						 c_white, 1.0);
	draw_sprite_part_ext(suiChoiceBox, 2,	// draw bottom corner
						 0, 0,
						 4 + box_xblend1 * (box_hw - 4),
						 20 * saturate((box_yblend0 - ((box_h - 20) / box_h)) * (box_h / 20)),
						 dx - box_hw, dy + box_h - 20,
						 1.0, 1.0, c_white, 1.0);
						 
	// Draw the right side
	draw_sprite_part_ext(suiChoiceBox, 0,	// draw top line
						 250 - box_hw, 0,
						 box_xblend0 * (box_hw - 4), 20,
						 dx, dy,
						 1.0, 1.0, c_white, 1.0);
	draw_sprite_part_ext(suiChoiceBox, 0,	// draw corner
						 250 - box_hw, 0,
						 box_hw, 20 * saturate(box_yblend0 * (box_h / 20)),
						 dx, dy,
						 1.0, 1.0, c_white, 1.0);
	draw_sprite_part_ext(suiChoiceBox, 1,	// draw wall
						 250 - box_hw, 0,
						 box_hw, 20.0,
						 dx, dy + 20,
						 1.0,
						 (1/20.0) * (box_h - 40) * saturate((box_yblend0 - (20 / box_h)) * (box_h / (box_h - 40))),
						 c_white, 1.0);
	draw_sprite_part_ext(suiChoiceBox, 2,	// draw bottom corner
						 250 - 4 - box_xblend1 * (box_hw - 4), 0,
						 4 + box_xblend1 * (box_hw - 4),
						 20 * saturate((box_yblend0 - ((box_h - 20) / box_h)) * (box_h / 20)),
						 dx + (1.0 - box_xblend1) * (box_hw - 4), dy + box_h - 20,
						 1.0, 1.0, c_white, 1.0);
						 
	// draw lights on each box border
	draw_set_color(c_white);
	draw_set_alpha(1.0 - box_glowblend);
	gpu_set_blendmode(bm_add);

	var light_x, light_y;
	light_x = dx - box_hw * box_xblend0 + box_hw * box_xblend1;
	light_y = dy + 1 + (box_h - 3) * box_yblend0;
	draw_circle_color(light_x, light_y, 4, c_white, c_black, false);
	light_x = dx + (box_hw - 1) * box_xblend0 - (box_hw - 1) * box_xblend1; // y is the same for the other side
	draw_circle_color(light_x, light_y, 4, c_white, c_black, false);
	
	gpu_set_blendmode(bm_normal);
	draw_set_alpha(1.0);
}

// Draw the text
if (current_name_count >= 1)
{
	draw_set_alpha(image_alpha);
	draw_set_font(display_font_bold);
	draw_set_halign(fa_center);
	draw_set_valign(fa_top);
	//draw_text(dx, dy + 15, input_name);
	var name_len = string_length(input_name);
	var name_len_base = string_width("m");
	var pen_x = dx - name_len_base * (name_len - 1) * 0.5;
	var pen_y = dy + 15;
	for (var i = 0; i < floor(current_name_count); ++i)
	{
		var c = string_char_at(input_name, i + 1);
		draw_set_color(c_black);
		draw_text(pen_x - 1, pen_y, c);
		draw_text(pen_x + 1, pen_y, c);
		draw_text(pen_x, pen_y - 1, c);
		draw_text(pen_x, pen_y + 1, c);
		draw_set_color(c_white);
		draw_text(pen_x, pen_y, c);
		pen_x += name_len_base;
	}
	
	draw_set_alpha(1.0);
}

if (current_display_count >= 1)
{
	draw_set_alpha(image_alpha);
	draw_set_font(display_font);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	
	dx = uiPosX + 10;
	dy = uiPosY + 2;
	
	var text_w = display_width - 20;
	var text_dx = display_font_height;
	var text_refw = string_width("m");
	var penw = 2;
	var penx = 0;
	var peny = 0;
	for (var i = 0; i < floor(current_display_count); ++i)
	{
		var char = string_char_at(display_text,i + 1);
		
		var xoffset = 0;
		var yoffset = 0;
		var penc = c_gold;
		
		// draw the text
	    draw_set_color( exists(o_CtsBlackBoxes) ? c_dkgray : make_color_rgb(239, 216, 161) );
	    draw_text(dx + penx + xoffset, dy + peny + 1 + yoffset, char);    
		if (penc == c_gold)
		{	// gold (and other colors) get a special outline
			draw_set_color( c_black );
			draw_text(dx + penx + xoffset, dy + peny + 1 + yoffset, char);
			draw_text(dx + penx + xoffset, dy + peny - 1 + yoffset, char);
			draw_text(dx + penx + 1 + xoffset, dy + peny + yoffset, char);
			draw_text(dx + penx - 1 + xoffset, dy + peny + yoffset, char);
		}
	    draw_set_color( penc );
	    draw_text(dx + penx + xoffset, dy + peny + yoffset, char);
		
		// do a lookahead for dropping a line if currently on a space
	    var override_drop = false;
	    if ( char == " " )
	    {
	        var vpenx = penx;
	        var n = i + 1, next_char;
	        do
	        {
	            next_char = string_char_at(display_text, n+1);
	            if (next_char != " ")
	            {
	                vpenx += ceil(text_dx * string_width(next_char)/text_refw) + penw;
	                if (vpenx >= text_w) override_drop = true;
	            }
	            n++;
	        }
	        until (next_char == " " || n >= floor(current_display_count) || override_drop);
	    }
    
	    // move the pen
	    penx += ceil(text_dx * string_width(char)/text_refw) + penw;
	    if ( override_drop || (char == " " && penx >= text_w) )
	    {
	        penx = 0;
	        peny += text_dx + 5;
	    }
	}
	
	draw_set_alpha(1.0);
}
// Blend as we arise
var blend_itempos0 = smoothstep(saturate(itemlight_alpha));
var blend_itempos1 = smoothstep(saturate(itemcenter_alpha));

// Set item position & blend over time to center
var uiposx_expected = GameCamera.x - display_width / 2;
var uiposy_expected = GameCamera.y;
var item_dx = display_item_startx + (uiPosX - uiposx_expected);
var item_dy = display_item_starty - 40 * blend_itempos0 + (uiPosY - uiposy_expected);
item_dx = lerp(item_dx, uiPosX + display_width / 2, blend_itempos1);
item_dy = lerp(item_dy, uiPosY - 16, blend_itempos1);
if (exists(input_actor))
{	// Should probably be in Step, but this is where the position is calculated.
	input_actor.x = item_dx; // Thus, here in Draw it is!
	input_actor.y = item_dy;
}

var item_sprite = object_get_sprite(input_actor);
// draw the light rectangles behind the item
if (image_alpha < 1.0 && done_alpha < 1.0)
{
	draw_set_color(c_white);
	draw_set_alpha(saturate((itemlight_alpha - 0.5) * 2.0) * 0.5 * saturate(1.0 - max(done_alpha, image_alpha)));
	var iangle_divs = 5;
	var iangle_step = 360 / iangle_divs;
	var iangle_offset = -current_time * 0.1;
	for (var iangle = 0; iangle < 360; iangle += iangle_step)
	{
		draw_triangle(item_dx, item_dy,
					  item_dx + lengthdir_x(1000, iangle_offset + iangle),
					  item_dy + lengthdir_y(1000, iangle_offset + iangle),
					  item_dx + lengthdir_x(1000, iangle_offset + iangle + iangle_step * 0.5),
					  item_dy + lengthdir_y(1000, iangle_offset + iangle + iangle_step * 0.5),
					  false);
	}
	draw_set_alpha(1.0);
}
// darw the item outline
shader_set(sh_colormaskAlphatest);
draw_set_color(c_white);
draw_sprite_ext(item_sprite, 0, item_dx - 1, item_dy, 1.0, 1.0, 0.0, c_white, blend_itempos0);
draw_sprite_ext(item_sprite, 0, item_dx + 1, item_dy, 1.0, 1.0, 0.0, c_white, blend_itempos0);
draw_sprite_ext(item_sprite, 0, item_dx, item_dy - 1, 1.0, 1.0, 0.0, c_white, blend_itempos0);
draw_sprite_ext(item_sprite, 0, item_dx, item_dy + 1, 1.0, 1.0, 0.0, c_white, blend_itempos0);
shader_reset();
// draw the item sprite itself
draw_sprite(item_sprite, 0, item_dx, item_dy);

if (!input_disable)
{
    // Draw the continue button
    var scale = bouncestep(done_alpha * image_alpha);
	draw_sprite_ext(sui_buttonPress3, 0, uiPosX + box_hw, uiPosY + box_h * 0.5 - 8, scale, scale, 0, c_white, min(1, done_alpha*4.0));
}