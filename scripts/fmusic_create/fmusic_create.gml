/// @description faudio_create_music()

if (exists(ob_musicPlayer))
{
	ob_musicPlayer.m_fadeOut = true;
}

var music_player = new2(ob_musicPlayer);
	//music_player.m_syncGroup = audio_create_sync_group(true);
	music_player.music_caller = ob_CtsTalker;

return music_player;