with (Settings)
{
    ini_open("settings.ini");
    
	audio_total_volume	= ini_read_real("audio", "total_volume", 1.0);
	audio_sfx_volume	= ini_read_real("audio", "sfx_volume", 1.0);
	audio_music_volume	= ini_read_real("audio", "music_volume", 1.0);
	audio_speech_volume	= ini_read_real("audio", "speech_volume", 1.0);

    ini_close();
}

