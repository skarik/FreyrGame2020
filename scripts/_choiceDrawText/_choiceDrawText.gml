function _choiceDrawText() {
	var blackbox = ((iexists(o_CtsBlackBoxes) || display_blackbox_override) && !display_whitebox_override);

	var dx, dy;
	dx = uiPosX; 
	dy = uiPosY;

	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_set_alpha(smoothstep((image_alpha-0.5)*2.0));

	draw_set_font(display_font);
	var text_dx = display_font_height;
	var text_refw = string_width(string_hash_to_newline("m"));

	var text_w = display_width;
	var penx = 0;
	var peny = 0;
	var penc = c_black;
	var penw = 2;

	for (var option = 0; option < input_choice_count; ++option)
	{
	    var display_text = input_choice[option];
	    for (var i = 0; i < floor(min(current_display_count, string_length(display_text))); ++i)
	    {
	        var char = string_char_at(display_text,i + 1);
        
	        // Set color based on selection
	        if (option == display_choice)
	            penc = c_gold;
	        else
				penc = blackbox ? c_white : c_black;
            
	        // draw the text
	        draw_set_color( (option == display_choice) ? c_gray : (blackbox ? c_dkgray : c_white) );
	        draw_text(dx + penx, dy + peny + 1, string_hash_to_newline(char));    
	        draw_set_color( penc );
	        draw_text(dx + penx, dy + peny, string_hash_to_newline(char));
        
	        // move the pen
	        penx += ceil(text_dx * string_width(string_hash_to_newline(char))/text_refw) + penw;
	    }
	    // Go to next line
	    penx = 0;
	    peny += text_dx + 5;
	}

	/*for (var i = 0; i < floor(current_display_count); ++i)
	{
	    if ( display_flags[i] != 0 )
	    {
	        if ( display_flags[i] == ord('0') )
	            penc = c_white;
	        if ( display_flags[i] == ord('1') )
	            penc = c_red;
	        if ( display_flags[i] == ord('2') )
	            penc = c_gray;
	        if ( display_flags[i] == ord('b') )
	        {
	            draw_set_font(display_font_bold);
	            text_refw = string_width("m");
	            penw = 3;
	        }
	        if ( display_flags[i] == ord('$') )
	        {
	            draw_set_font(display_font);
	            text_refw = string_width("m");
	            penw = 2;
	        }
	        // Newline!
	        if ( display_flags[i] == ord('#') )
	        {
	            penx = 0;
	            peny += text_dx + 3
	        }
	    }

	    var char = string_char_at(display_text,i + 1);
    
	    // draw the text
	    draw_set_color( c_black );
	    draw_text(dx + penx, dy + peny + 1, char);    
	    draw_set_color( penc );
	    draw_text(dx + penx, dy + peny, char);
    
	    // do a lookahead for dropping a line if currently on a space
	    var override_drop = false;
	    if ( char == ' ' )
	    {
	        var vpenx = penx;
	        var n = i + 1, next_char;
	        do
	        {
	            next_char = string_char_at(display_text, n+1);
	            if (next_char != ' ')
	            {
	                vpenx += ceil(text_dx * string_width(next_char)/text_refw) + penw;
	                if (vpenx >= text_w) override_drop = true;
	            }
	            n++;
	        }
	        until (next_char == ' ' || n >= floor(current_display_count) || override_drop);
	    }
    
	    // move the pen
	    penx += ceil(text_dx * string_width(char)/text_refw) + penw;
	    if ( override_drop || (char == ' ' && penx >= text_w) )
	    {
	        penx = 0;
	        peny += text_dx + 3;
	    }
	}*/

	draw_set_alpha(1.0);




}
