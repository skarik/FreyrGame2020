// Called by Game.onRoomEnd() as well as on first run.

debugOut("Room ending. Cleaning up.");

col3_internal_query_reset();
area3_internal_query_reset();
vtile_internal_query_reset();