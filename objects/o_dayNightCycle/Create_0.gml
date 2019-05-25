/// @description singleton this nonsense

if (singleton_this()) exit;

depth = -9500;
persistent = true;

m_overlayColor = c_black;
m_ambientLight = c_black;
m_blendSunsetToDay = 0.0;
m_blendSunsetToNight = 0.0;

m_day = 1;
m_timeOfDay = 8;
m_hourPassed = false;

if (!exists(o_darkness)) new(o_darkness);