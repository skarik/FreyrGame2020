/// @description gaudio_create_stream(filename)
/// @param filename

var filename = argument0;
var result_sound = null;

if (!file_exists(filename))
{
	show_error("Could not find the audio '" + filename + "' for open.", true);
    return null;
}

var extension_pos = string_rpos(".", filename);
var extension = string_lower(string_copy(filename, extension_pos + 1, string_length(filename) - extension_pos));
if (extension == "wav")
{
	var data_buffer = buffer_load(filename);
	
	// Read in the wave header
	var header_chunkID = "";
	for (var i = 0; i < 4; ++i)
		header_chunkID += chr(buffer_read(data_buffer, buffer_u8));
	var header_filesize = buffer_read(data_buffer, buffer_u32);
	var header_format = buffer_read(data_buffer, buffer_u32);
	
	if (header_chunkID != "RIFF")
	{
		buffer_delete(data_buffer);
		show_error("Invalid WAVE file.", true);
		return null;
	}
	
	// Read in the wave "fmt " block
	var fmt_chunkID = "";
	for (var i = 0; i < 4; ++i)
		fmt_chunkID += chr(buffer_read(data_buffer, buffer_u8));
	var fmt_size = buffer_read(data_buffer, buffer_u32);
	var fmt_format = buffer_read(data_buffer, buffer_u16);
	var fmt_numChannels = buffer_read(data_buffer, buffer_u16);
	var fmt_sampleRate = buffer_read(data_buffer, buffer_u32);
	var fmt_byteRate = buffer_read(data_buffer, buffer_u32);
	var fmt_blockAlign = buffer_read(data_buffer, buffer_u16);
	var fmt_bitsPerSample = buffer_read(data_buffer, buffer_u16);
	
	// Read in the wave "data" block
	var data_chunkID = "";
	for (var i = 0; i < 4; ++i)
		data_chunkID += chr(buffer_read(data_buffer, buffer_u8));
	var data_chunkSize = buffer_read(data_buffer, buffer_u32);
	
	// Create data based on the data block
	result_sound = audio_create_buffer_sound(data_buffer,
											 (fmt_bitsPerSample == 16) ? buffer_s16 : buffer_u8,
											 fmt_sampleRate,
											 buffer_tell(data_buffer),
											 data_chunkSize,
											 (fmt_numChannels == 2) ? audio_stereo : audio_mono);
}
else if (extension == "ogg")
{
	result_sound = audio_create_stream(filename);
}
else
{
	show_error("Audio file '" + filename + "' is an unknown format.", true);
    return null;
}

debugOut("Loaded audio '" + filename + "'");

return result_sound;

// TODO: handle sound reuse and manage memory properly