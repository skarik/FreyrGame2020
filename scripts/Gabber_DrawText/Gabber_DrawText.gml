var dx, dy;
dx = uiPosX; 
dy = uiPosY + (exists(input_actor) ? 10 : 0);

var seed = mt19937_get_state();//random_get_seed();
//random_set_seed(floor(current_time / 1000.0 * 30.0));
mt19937_seed(floor(current_time / 1000.0 * 30.0));

draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_alpha(smoothstep((image_alpha-0.5)*2.0));

draw_set_font(display_font);
var text_dx = display_font_height;
var text_refw = string_width("m");

var text_w = display_width;
var penx = 0;
var peny = 0;
var penc = exists(o_CtsBlackBoxes) ? c_white : c_black;
var penw = 2;
var penwiggle = false;
var penshake = false;
var penwigglex = false;
for (var i = 0; i < floor(current_display_count); ++i)
{
    if ( display_flags[i] != 0 )
    {
        if ( display_flags[i] == ord("0") )
            penc = exists(o_CtsBlackBoxes) ? c_white : make_color_rgb(31, 36, 10);
        if ( display_flags[i] == ord("1") )
            penc = c_red;
        if ( display_flags[i] == ord("2") )
            penc = c_gray;
		if ( display_flags[i] == ord("3") )
			penc = merge_color(c_electricity, c_navy, 0.5);
		if ( display_flags[i] == ord("4") )
			penc = c_gold;
		if ( display_flags[i] == ord("5") )
			penc = c_riftgreen;
        if ( display_flags[i] == ord("b") )
        {
            draw_set_font(display_font_bold);
            text_refw = string_width("m");
            penw = 3;
        }
        if ( display_flags[i] == ord("$") )
        {
            draw_set_font(display_font);
            text_refw = string_width("m");
            penw = 2;
			penwiggle = false;
			penshake = false;
			penwigglex = false;
        }
		if ( display_flags[i] == ord("w") )
			penwiggle = true;
		if ( display_flags[i] == ord("s") )
			penshake = true;
		if ( display_flags[i] == ord("h") )
			penwigglex = true;
        // Newline!
        if ( display_flags[i] == ord("#") )
        {
            penx = 0;
            peny += text_dx + 3
        }
    }

    var char = string_char_at(display_text,i + 1);
    
	var xoffset = 0;
	var yoffset = 0;
	if (penwiggle)
		yoffset += round(sin(current_time / 200.0 + i * 0.76) * 3.4);
	if (penwigglex)
		xoffset += round(sin(current_time / 230.0 - i * 0.96) * (penw + 0.4));
	if (penshake) {
		xoffset += round(mt19937_random_range(-1.4, 1.4));
		yoffset += round(mt19937_random_range(-1.4, 1.4));
	}
	
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
		until (next_char == " " || n >= string_length(display_text) || override_drop);
        //until (next_char == " " || n >= floor(current_display_count) || override_drop);
    }
    
    // move the pen
    penx += ceil(text_dx * string_width(char)/text_refw) + penw;
    if ( override_drop || (char == " " && penx >= text_w) )
    {
        penx = 0;
        peny += text_dx + 5;
    }
}

//random_set_seed(seed);
mt19937_set_state(seed);

draw_set_alpha(1.0);