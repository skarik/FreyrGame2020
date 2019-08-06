/// @description Init defaults

m_music = null;
m_tracks = array_create(0);
m_trackVolume = array_create(0);

if (exists(object_index))
{
	delete(this);
}