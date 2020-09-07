function savestateFarmSave() {
	with (o_farmAreaManager)
	{
		event_user(0);
		var save_buffer = farmBuildSaveState();
		buffer_save(save_buffer, buffer_name);
	}


}
