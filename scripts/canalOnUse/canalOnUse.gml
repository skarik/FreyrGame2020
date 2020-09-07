function canalOnUse(argument0) {
	var _itemType = argument0;

	// Check for existing canal
	if (!iexists(collision_rectangle(currentBuildableX + 1, currentBuildableY + 1, currentBuildableX + 14, currentBuildableY + 14, o_miniCanalWater, false, true)))
	{
		// delete any land
		idelete(collision_point(currentBuildableX + 8, currentBuildableY + 8, o_fieldSquare, false, true));
		// create canal
		instance_create_depth(currentBuildableX, currentBuildableY, 11, o_miniCanalWater);
	}

	// Decrement belt usage
	_playerInteractItemDecrementBelt();


}
