/// @description Insert description here
// You can write your code in this editor

m_definition = soundscapeGetByName(m_soundscape);
if (m_definition == null)
{
	debugOut("Could not find soundscape definition \"" + m_definition + "\" in any definition");
	idelete(this);
	exit;
}

m_strength = 0.0;
m_fadeoutRequested = false;
m_fadeinRequested = false;

m_home = room;
m_homeless = false;