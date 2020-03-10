/// @description gaudio_create_stream(filename)
/// @param filename

var filename = argument0;

if (!file_exists(filename))
{
	show_error("Could not find the audio '" + filename + "' for open.", true);
    return null;
}

return audio_create_stream(filename);

// TODO: handle sound reuse and manage memory properly