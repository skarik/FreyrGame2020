// todo: load up questids.txt and parse those IDs for loading in from the cutscene files

global.ctsBackend_QuestIds = ds_map_create();

var fp = fioTextOpenRead("sys/questids.txt");
if (fp == -1)
{
    show_error("Could not find the cutscene 'sys/questids.txt' for open.", true);
    return null;
}

while (!file_text_eof(fp))
{
	var line = file_text_readln(fp);
	
	if (string_count("#macro", line) == 1 && string_count("kQid", line) == 1)
	{
		// Parse out the sequence name:
		var keyvalue_pos = string_pos("kQid", line) + 4;
		var sequence_keyvalue = string_copy(line, keyvalue_pos, string_length(line) - keyvalue_pos);
		sequence_keyvalue = string_fix_whitespace(sequence_keyvalue);
		
		var keyvalue_pos_space = string_pos(" ", sequence_keyvalue);
		var sequence_key = string_rtrim(string_copy(sequence_keyvalue, 1, keyvalue_pos_space));
		var sequence_value = string_copy(sequence_keyvalue, keyvalue_pos_space, string_length(sequence_keyvalue) - keyvalue_pos_space);
		sequence_value = string_rtrim(string_ltrim(sequence_value));
		sequence_value = real(sequence_value);
		
		// Save the key-value pair
		global.ctsBackend_QuestIds[?sequence_key] = sequence_value;
		//ds_map_add(global.ctsBackend_QuestIds, sequence_key, sequence_value);
		
		debugOut("loaded cts backend quest id: " + "\"" + sequence_key + "\" = \"" + string(sequence_value) + "\"");
	}
}

fioTextClose(fp);