/// @function savestateWriteBufferHeader(buffer, header, version)
/// @param buffer {Buffer}
/// @param header {String[4]}
/// @param version {Nonzero Int32}
function savestateWriteBufferHeader(argument0, argument1, argument2) {

	var buffer = argument0;
	var header_to_check_str = argument1;
	var version = argument2;

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

	// Write the header
	buffer_write(buffer, buffer_u8, header_to_check[0]);
	buffer_write(buffer, buffer_u8, header_to_check[1]);
	buffer_write(buffer, buffer_u8, header_to_check[2]);
	buffer_write(buffer, buffer_u8, header_to_check[3]);
	buffer_write(buffer, buffer_s32, version);


}
