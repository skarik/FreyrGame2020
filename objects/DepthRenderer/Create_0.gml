/// @description Create lists of objects to track

// The purpose of this depth renderer is to manually control the order of 3D items drawn.
// This allows for both use of the depth buffer and grouping items using the same shader, which
// minimizes the GPU state updates that GMS2 deigns necessary. This increases the CPU time in
// game-side code, but has a much larger reduction in engine-side code.
// Also, it fixes some shitty artifacting, which is a plus.

if (singleton_this()) exit;

depth = -1;
persistent = true;

//m_objects = ds_list_create();
//m_renderQueue = ds_list_create();
m_objects = array_create(0);
m_renderQueue = array_create(0);

m_objectsDirty = true;

m_renderMatrices = array_create(0);