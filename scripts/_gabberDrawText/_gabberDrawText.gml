function _gabberDrawText() {
	var blackbox = ((iexists(o_CtsBlackBoxes) || display_blackbox_override) && !display_whitebox_override);
	var dx, dy;
	dx = uiPosX; 
	dy = uiPosY + (iexists(input_actor) ? 10 : 0);

	var seed = mt19937_get_state();
	mt19937_seed(floor(current_time / 1000.0 * 30.0));

	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_set_alpha(smoothstep((image_alpha-0.5)*2.0));

	// Set up fonts
	var l_display_font = input_minimal ? display_font_minimal : display_font;
	var l_display_font_bold = input_minimal ? display_font_minimal_bold : display_font_bold;
	var l_display_font_height = input_minimal ? display_font_minimal_height : display_font_height;
	var l_display_mumble_font = display_font_mumble;
	var l_display_mumble_font_bold = display_font_mumble_bold;

	draw_set_font(l_display_font);
	var text_dx = l_display_font_height;
	var text_refw = string_width("m");

	// Lilac for motses
#macro c_motsestext make_color_rgb(229, 139, 210)

	var text_w = display_width;
	var penx = 0;
	var peny = 0;
	var penc = blackbox ? c_white : c_black;
	var penw = 2;
	var penwiggle = false;
	var penshake = false;
	var penwigglex = false;
	var pensmol = false;
	var penbold = false;
	for (var i = 0; i < floor(current_display_count); ++i)
	{
	    if ( is_array(display_flags[i]) )
	    {
			var flags = display_flags[i];
			var flags_len = array_length_1d(flags);
			for (var iFlag = 0; iFlag < flags_len; ++iFlag)
			{
				var flag = flags[iFlag];
		        if ( flag == ord("0") )
		            penc = blackbox ? c_white : make_color_rgb(31, 36, 10);
		        if ( flag == ord("1") )
		            penc = c_red;
		        if ( flag == ord("2") )
		            penc = c_gray;
				if ( flag == ord("3") )
					penc = merge_color(c_electricity, c_navy, 0.5);
				if ( flag == ord("4") )
					penc = c_gold;
				if ( flag == ord("5") )
					penc = c_riftgreen;
		        if ( flag == ord("b") )
		        {
					penbold = true;
		        }
		        if ( flag == ord("$") )
		        {
					penbold = false;
					penwiggle = false;
					penshake = false;
					penwigglex = false;
					pensmol = false;
		        }
				if ( flag == ord("w") )
					penwiggle = true;
				if ( flag == ord("s") )
					penshake = true;
				if ( flag == ord("h") )
					penwigglex = true;
				if ( flag == ord("q") )
					pensmol = true;
				if ( flag == ord("M") )
				{ // motses shorthand
					penc = c_motsestext;
					//penbold = true;
				}
		        // Newline!
		        if ( flag == ord("#") )
		        {
		            penx = 0;
		            peny += text_dx + 3
		        }
			}
		
			// Update complex overlapping font flags at this font
			if (!pensmol)
			{
				if (!penbold)
				{
					draw_set_font(l_display_font);
				    text_refw = string_width("m");
				    penw = 2;
				}
				else
				{
					draw_set_font(l_display_font_bold);
				    text_refw = string_width("m");
				    penw = 3;
				}
			}
			else
			{
				if (!penbold)
				{
					draw_set_font(l_display_mumble_font);
				    text_refw = string_width("m");
				    penw = 1;
				}
				else
				{
					draw_set_font(l_display_mumble_font_bold);
				    text_refw = string_width("m");
				    penw = 2;
				}
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
		if (pensmol)
		{
			xoffset *= 0.5;
			yoffset *= 0.5;
			xoffset += 0.4;
			yoffset += l_display_font_height * 0.5;
		
			xoffset = round(xoffset);
			yoffset = round(yoffset) - 1;
		}
	
	    // draw the text
		if (!input_minimal)
		{
			if (penc == c_gold || penc == c_motsestext)
			{	// gold (and other colors) get a special outline
				draw_set_color( c_black );
				draw_text(dx + penx + xoffset, dy + peny + 1 + yoffset, char);
				draw_text(dx + penx + xoffset, dy + peny - 1 + yoffset, char);
				draw_text(dx + penx + 1 + xoffset, dy + peny + yoffset, char);
				draw_text(dx + penx - 1 + xoffset, dy + peny + yoffset, char);
				draw_text(dx + penx - 1 + xoffset, dy + peny + 1 + yoffset, char);
				draw_text(dx + penx + 1 + xoffset, dy + peny - 1 + yoffset, char);
				draw_text(dx + penx + 1 + xoffset, dy + peny + 1 + yoffset, char);
				draw_text(dx + penx - 1 + xoffset, dy + peny - 1 + yoffset, char);
			}
			else
			{	// otherwise, do simple dropshadow outline
				draw_set_color( blackbox ? c_dkgray : make_color_rgb(180, 180, 180) );
				draw_text(dx + penx + xoffset, dy + peny + 1 + yoffset, char);
			}
		}
		// no box, need white outline
		else
		{
			//draw_set_color(make_color_rgb(239, 216, 161));
			//draw_set_color(c_white);
			draw_set_color(merge_color(c_white, make_color_rgb(239, 216, 161), 0.5));
			draw_text(dx + penx + xoffset, dy + peny + 1 + yoffset, char);
			draw_text(dx + penx + xoffset, dy + peny - 1 + yoffset, char);
			draw_text(dx + penx + 1 + xoffset, dy + peny + yoffset, char);
			draw_text(dx + penx - 1 + xoffset, dy + peny + yoffset, char);
		
			draw_text(dx + penx + 1 + xoffset, dy + peny - 1 + yoffset, char);
			draw_text(dx + penx - 1 + xoffset, dy + peny - 1 + yoffset, char);
			draw_text(dx + penx + 1 + xoffset, dy + peny + 1 + yoffset, char);
			draw_text(dx + penx - 1 + xoffset, dy + peny + 1 + yoffset, char);
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


}
