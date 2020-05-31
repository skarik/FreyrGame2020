/// @description options

// Inherit the parent event
event_inherited();

#region Options

m_name = "Ruined Magic Switch";
m_actionName = "Fiddle";
m_canPickUp = false;
m_isSuperHeavy = false;
m_canThrow = false;
m_airFriction = 100;

#endregion

// Create demuxer
m_relay = inew(o_livelyPoweredRelay);
// Set power source of demuxer to our source
m_relay.m_powerSource = m_powerSource;
// Set up inital power input
m_relay.m_powerInput = m_enabled ? 1.0 : 0.0;

// Set new power source for power system redirect
m_powerSource = m_relay;