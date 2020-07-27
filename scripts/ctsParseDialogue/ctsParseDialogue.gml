

// inputs: input_actor, input_name, input_text
// outputs: display_text, display_flags

// Replace big system strings in input_text
if (iexists(o_PlayerStats))
{
	input_text = string_replace(input_text, "[PLAYER]", o_PlayerStats.m_name);
	input_text = string_replace(input_text, "[PLAYER_NICKNAME]", string_copy(o_PlayerStats.m_name, 1, 2));
}
// Replace unicode characters for sanity
input_text = string_replace(input_text, "\u2018", "'");
input_text = string_replace(input_text, "\u2019", "'");
input_text = string_replace(input_text, "\u201C", "\"");
input_text = string_replace(input_text, "\u201D", "\"");


var str_len = 0;

// Initialize text
display_text = "";
for (var i = 0; i <= string_length(input_text); ++i)
{
	display_flags[i] = null;
}

// Go through the input_text character by character to parse
for (var i = 1; i <= string_length(input_text); ++i)
{
    var next_char = string_char_at(input_text, i);
    if (next_char == "$")
    {   // Escape character! We pull the next character as the code.
        i += 1;
        next_char = string_char_at(input_text, i);
        
		//display_flags[str_len] = ord(next_char);
		if (!is_array(display_flags[str_len]))
		{
			display_flags[str_len] = array_create(0);
		}
		var flags = display_flags[str_len];
		flags[array_length_1d(flags)] = ord(next_char);
		display_flags[str_len] = flags;
    }
    else
    {   // It's a display character! Just save it and keep track of the length.
        display_text += next_char;
        str_len++;
    }
}
