/// @description Set up surfaces

event_inherited();

m_bufferProjection = null;

m_emissive = new(o_lightEmissiveDepth_User5);
m_emissive.target = id;
m_emissive.mask = false;