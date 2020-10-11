// set up initial vars
collider = null;
light = null;
emissive = null;
particles = null;
elevation = null;
source_layer = null;
index = null;

depthInit();
depthSetShadowDrawFunction(depthShadowDrawPropShadow);

m_alarmCulling = 5;

drawbuf_set_reflection(false);
