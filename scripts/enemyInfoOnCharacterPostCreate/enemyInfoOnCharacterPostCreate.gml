/// @function enemyInfoOnCharacterPostCreate()
/// @desc Called the frame after character creation to verify that values are properly set up.
function enemyInfoOnCharacterPostCreate() {

	if (m_saveTracked)
	{
		if (m_enemyinfo_id == null)
		{
			show_error("The " + object_get_name(object_index) + " called \"" + string(id)
						+ "\" on layer \"" + layer_get_name(layer) + "\" was not tracked properly.\n"
						+ "This will causes issues with checkpoints and save files.\n"
						+ "Use a spawner for this instance instead.\n\n",
						false);
		}
	}


}
