/// @description options

// Inherit the parent event
event_inherited();

#region Options

m_name = "Ruined Magic Splitter";
m_actionName = "Fiddle";
m_canPickUp = false;
m_isSuperHeavy = false;
m_canThrow = false;
m_airFriction = 100;

#endregion

// Create demuxer
m_demuxer = new(o_livelyPoweredDemux);
// Set power source of demuxer to our source
m_demuxer.m_powerSource = m_powerSource;

// Set new power source for power system redirect
m_powerSource = m_demuxer;