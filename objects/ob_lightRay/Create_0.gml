/// @description Render light ray surface

m_lightBufferWidth = 0;
m_lightBufferHeight = 0;
m_lightBuffer = null;
m_lightBufferOriginX = 0;
m_lightBufferOriginY = 0;

#macro kLightrayBlend_TopFade 0
#macro kLightrayBlend_DoubleFade 1

m_lightrayBlendStyle = kLightrayBlend_TopFade;

visible = false;