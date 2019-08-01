/// @description Record mode

if (Debug.recordModeEnabled)
{
	record_shot[record_shot_count] = surface_create(Screen.width / Screen.pixelScale, Screen.height / Screen.pixelScale);
	surface_copy(record_shot[record_shot_count], offset_x, offset_y, m_gameSurface);
	
	record_shot_count += 1;
}