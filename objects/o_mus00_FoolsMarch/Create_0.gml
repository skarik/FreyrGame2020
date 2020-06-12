/// @description set tracks

event_inherited();

// set up tracks
m_tracks = array_create(6);
m_tracks[0] = "music/foolsmarch_ambient.ogg";
m_tracks[1] = "music/foolsmarch_basic.ogg";
m_tracks[2] = "music/foolsmarch_beat.ogg";
m_tracks[3] = "music/foolsmarch_excite1.ogg";
m_tracks[4] = "music/foolsmarch_excite2.ogg";
m_tracks[5] = "music/foolsmarch_finale.ogg";

m_excitementLevel = 0;
m_excitementTimer = 0.0;

m_wasClimaxing = false;