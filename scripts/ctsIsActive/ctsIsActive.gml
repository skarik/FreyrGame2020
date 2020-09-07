function ctsIsActive() {
	if (global._cutscene_main != null)
	{
		var bIsDone = true;
		with (global._cutscene_main)
		{
			bIsDone = cutsceneIsDone();
		}
		return !bIsDone;
	}
	return false;


}
