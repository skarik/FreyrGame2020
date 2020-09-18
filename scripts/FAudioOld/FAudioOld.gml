/// @function faudio_play2_file(filename, streamed, looped)
/// @description Plays file with a heavily managed audio object
/// @param filename
/// @param streamed
/// @param looped
function OLD_faudio_play2_file(argument0, argument1, argument2) {

	var filename = argument0;
	var streamed = argument1;
	var looped = argument2;

	if (!file_exists(filename))
	{
		show_error("Could not find the audio '" + filename + "' for open.", true);
	    return null;
	}

	var audio_player = inew(ob_audioPlayer2);

	if (streamed)
	{
		audio_player.m_streamed = streamed;
		audio_player.m_stream = audio_create_stream(filename);
		audio_player.m_audio = 	audio_play_sound(audio_player.m_stream, 100, looped);
		audio_sound_gain(audio_player.m_audio, Settings.audio_sfx_volume * Settings.audio_total_volume, 0.0);
	}

	return audio_player;
}

/// @description faudio_create_stream(filename)
/// @param filename
function OLD_faudio_create_stream(argument0) {

	if (!iexists(AudioStreams))
	{
		inew(AudioStreams);
	}

	var filename = argument0;
	var result_sound = null;

	// Find the existing audio in the AudioStreams
	var music_count = array_length_1d(AudioStreams.music);
	/*for (var i = 0; i < music_count; ++i)
	{
		if (AudioStreams.music_filename[i] == filename)
		{
			return AudioStreams.music[i];
		}
	}*/

	// We're here? Time to load:

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

	// Add the new audio streams
	AudioStreams.music[music_count] = result_sound;
	AudioStreams.music_filename[music_count] = filename;
	AudioStreams.music_creation_time[music_count] = Time.time;

	// Return newly loaded music track
	return AudioStreams.music[music_count];
}

/// @description faudio_play_sound(soundid, priority, loops, channel)
/// @param soundid
/// @param priority
/// @param loops
/// @param channel
function OLD_faudio_play_sound(argument0, argument1, argument2, argument3) {

	var soundid = argument0;
	if (is_string(soundid))
	{
		soundid = faudio_create_stream(soundid);
	}
	var channel = argument3;

	var sound = audio_play_sound(soundid, argument1, argument2);
	if (channel == kSoundChannelKey || channel == kSoundChannelWorld)
		audio_sound_gain(sound, Settings.audio_sfx_volume * Settings.audio_total_volume, 0.0);
	else if (channel == kSoundChannelMusic)
		audio_sound_gain(sound, Settings.audio_music_volume * Settings.audio_total_volume, 0.0);
	else if (channel == kSoundChannelSpeech)
		audio_sound_gain(sound, Settings.audio_speech_volume * Settings.audio_total_volume, 0.0);
	return sound;
}

/// @function faudio_sound_get_length( soundid )
/// @param soundid {Sound}
function OLD_faudio_sound_get_length(argument0) {
	return audio_sound_length(argument0);
}

/// @description faudio_sound_set_gain(soundid, gain)
/// @param soundid
/// @param gain
function OLD_faudio_sound_set_gain(argument0, argument1) {
	audio_sound_gain(argument0, Settings.audio_sfx_volume * Settings.audio_total_volume * argument1, 0.0);
}

/// @description faudio_sound_set_pitch(soundid, pitch)
/// @param soundid
/// @param pitch
function OLD_faudio_sound_set_pitch(argument0, argument1) {
	audio_sound_pitch(argument0, argument1);
}

/// @description faudio_sound_stop(soundid)
/// @param soundid
function OLD_faudio_sound_stop(argument0) {
	audio_stop_sound(argument0);
}
