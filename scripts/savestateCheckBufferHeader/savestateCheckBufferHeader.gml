/// @function savestateCheckBufferHeader(buffer, header)
/// @param buffer {Buffer}
/// @param header {String[4]}
/// @returns {Integer} - Version paired with the header. If header not found, reverts to previous read position and returns 0.
function savestateCheckBufferHeader(argument0, argument1) {

	var buffer = argument0;
	var header_to_check_str = argument1;

	// Create the check array
	var header_to_check = array_create(4);
	for (var i = 0; i < string_length(header_to_check_str); ++i)
	{
		header_to_check[i] = ord(string_char_at(header_to_check_str, i + 1));
	}
	for (var i = string_length(header_to_check_str); i < 4; ++i)
	{
		header_to_check[i] = 0;
	}

	// Load in the header
	var off_preheader = buffer_tell(buffer);
	var header = array_create(4);
	header[0] = buffer_read(buffer, buffer_u8);
	header[1] = buffer_read(buffer, buffer_u8);
	header[2] = buffer_read(buffer, buffer_u8);
	header[3] = buffer_read(buffer, buffer_u8);
	var version = 0;
	version = buffer_read(buffer, buffer_s32);

	// Check the header
	if (header[0] == header_to_check[0]
		&& header[1] == header_to_check[1]
		&& header[2] == header_to_check[2]
		&& header[3] == header_to_check[3])
	{
		if (debug_mode)
			debugOut("Savefile: Found " + header_to_check_str + " chunk, version " + string(version));
		return version;
	}
	else
	{
		if (debug_mode)
			debugOut("Savefile: No " + header_to_check_str + " chunk");
		buffer_seek(buffer, buffer_seek_start, off_preheader);
		return 0;
	}


}
