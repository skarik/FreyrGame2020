var suiChoiceBox = ((iexists(o_CtsBlackBoxes) || display_blackbox_override) && !display_whitebox_override) ? sui_choiceBox3Black : sui_choiceBox4;
var dx, dy;

draw_set_font(display_font);
var boxw_st = display_width + 8;
var boxh_st = _gabberBoxHeight();
var boxw = ceil( boxw_st * smoothstep(image_alpha*2) );
var boxh = max(10, ceil( boxh_st * bouncestep((image_alpha-0.5)*2) ));

var offYa = -7 * bouncestep((image_alpha-0.5)*2);
var offA = clamp(image_alpha*2, 0.0, 1.0);

x = uiPosX + boxw_st * 0.5; 
y = uiPosY + boxh;

/*var tC = make_colour_hsv(colour_get_hue(background_colour), 255, 90);
draw_set_color( merge_color( c_gray, tC, offA ) );
gpu_set_blendmode_ext( bm_dest_color, bm_src_color );
draw_rectangle( x-boxw*0.5-8,y+offYa-boxh,x+boxw*0.5+8,y+offYa+10, false );
gpu_set_blendmode( bm_normal );
draw_set_alpha( offA*0.7 );
draw_set_color( make_color_rgb(39,39,39) );
draw_rectangle( x-boxw*0.5-8,y+offYa-boxh,x+boxw*0.5+8,y+offYa+10, false );*/


// Draw the box container
//draw_sprite_ext( sprMessageBox, 0, x+10,y+offYa+4,1,1,0,c_white,offA );
draw_sprite_part_ext( suiChoiceBox, 0, 125-25,0,10,20, x-boxw*0.5,y+offYa-boxh-4, boxw/10,1.0, c_white, offA ); // top border
draw_sprite_part_ext( suiChoiceBox, 0, 0,0,15,20, x-boxw*0.5-9,y+offYa-boxh-4, 1.0,1.0,c_white, offA );  // left corner
draw_sprite_part_ext( suiChoiceBox, 0, 250-15,0,15,20, x+boxw*0.5+10-15,y+offYa-boxh-4, 1.0,1.0,c_white, offA ); // right corner
draw_sprite_part_ext( suiChoiceBox, 0, 125-10,0,20,20, x-10,y+offYa-boxh-4, 1.0,1.0,c_white, offA ); // gem

draw_sprite_part_ext( suiChoiceBox, 1, 125-25,0,10,20, x-boxw*0.5,y+offYa-boxh, boxw/10,boxh/20, c_white, offA ); // center
draw_sprite_part_ext( suiChoiceBox, 1, 0,0,20,20, x-boxw*0.5-9,y+offYa-boxh, 1.0,boxh/20, c_white, offA ); //left wall
draw_sprite_part_ext( suiChoiceBox, 1, 250-20,0,20,20, x+boxw*0.5+10-20,y+offYa-boxh, 1.0,boxh/20, c_white, offA ); //right wall

draw_sprite_part_ext( suiChoiceBox, 2, 125-25,0,10,20, x-boxw*0.5,y+offYa-7, boxw/10,1.0, c_white, offA ); // bottom border
draw_sprite_part_ext( suiChoiceBox, 2, 0,0,15,20, x-boxw*0.5-9,y+offYa-7, 1.0,1.0,c_white, offA ); // bottom left corner
draw_sprite_part_ext( suiChoiceBox, 2, 250-15,0,15,20, x+boxw*0.5+10-15,y+offYa-7, 1.0,1.0,c_white, offA ); // bottom right corner

if (iexists(input_actor))
{
	//draw_sprite_part_ext( suiChoiceBox, 3, 125-25,0,10,20, x-boxw*0.5,y+offYa-7, boxw/10,1.0, c_white, offA ); // bottom border
	draw_sprite_ext( suiChoiceBox, 3, x + clamp(input_actor.x - x - 19, -boxw * 0.5, boxw * 0.5), y + offYa - 7 + (18-5), 1.0, 1.0, 0.0, c_white, offA );
}

// draw the name
if (iexists(input_actor))
{
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_set_color(make_color_rgb(142, 126, 106));
	//draw_set_font(display_font_bold);
	draw_set_font(display_font);
	draw_set_alpha( offA );
	var penx = 0;
	var display_name = iexists(input_actor) ? input_actor.m_name : input_name;
	for (var i = 1; i <= string_length(display_name); ++i)
	{
		var next_character = string_char_at(display_name, i);
		draw_text(x - boxw * 0.5 + penx, y + offYa - boxh + 1, next_character);
		penx += string_width(next_character) + 2;
	}
}

if (!input_disable)
{
    // Draw the continue button
    var scale = bouncestep(done_alpha * image_alpha);
    //draw_sprite_ext(sui_buttonPress, 0, x,y+12, scale,scale,0, c_white, min(1, done_alpha*4.0));
	if (iexists(o_CtsBlackBoxes))
		draw_sprite_ext(sui_buttonPress2, 0, x + boxw * 0.5 - 4, y - 4, scale, scale, 0, c_white, min(1, done_alpha*4.0));
	else
		draw_sprite_ext(sui_buttonPress3, 0, x + boxw * 0.5 - 2, y - 4, scale, scale, 0, c_white, min(1, done_alpha*4.0));
    // draw button
    /*draw_set_alpha( clamp((done_alpha-0.5) * 2.0, 0,1) * image_alpha );
    //if (Input.gamepad)
    {
        draw_text_outline(x,y+12, "X", c_gold,false,4-3*scale);
    }*/
    //else
    //{
    //    draw_text_outline(x,y+12, "X", c_ltblue,false,4-3*scale); 
    //}
}

draw_set_alpha( 1.0 );