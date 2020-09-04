/// @description Set up the cts

event_inherited();

persistent = true;

m_state = 0;
m_fade = 0.0;
m_fadeTotalMessage = 0.0;
m_fadeOutTimer = 0.0;

// Rendering info
depth = kUiDepthHudBase - 35;

m_vfxWorldFlashRequested = false;
m_vfxWorldFlash = 0.0;