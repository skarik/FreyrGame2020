/// @description Init defaults

m_music = null;
m_tracks = array_create(0);
m_trackVolume = array_create(0);

if (instance_number(object_index) > 1)
{
	delete(this);
}