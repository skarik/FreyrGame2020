/// @description Create lists of objects to track

if (singleton_this()) exit;

depth = -1;
persistent = true;

m_objects = ds_list_create();
m_renderQueue = ds_list_create();

m_objectsDirty = true;