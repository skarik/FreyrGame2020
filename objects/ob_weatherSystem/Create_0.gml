/// @description Set up weather system

persistent = true;
depth = kUiDepthHudBase + 100;

#macro kWeatherStrengthZero 0.0
#macro kWeatherStrengthLight 1.0
#macro kWeatherStrengthFull 2.0
#macro kWeatherStrengthTorrential 3.0

m_strength = kWeatherStrengthZero;
m_windOffset = [0.0, 0.0];