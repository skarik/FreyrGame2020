// Called by Game.onRoomStart().

// Creates all doodads, converting 
doodadSetupOnRoomStart();

// Finds collision maps, saves them, marks them invisible
col3_internal_query_collision_maps();

// Finds water maps, saves them, marks them invisible.
// Creates water renderer if necessary.
area3_internal_query_and_init_water_maps();

// Set up the visual water
livelySetupWaterRendering();

// Set up all the floaters now
livelySetupFloaters();