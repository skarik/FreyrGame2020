/// @description CoNsUmE DiRt

if (cropIsMature(this))
{
	repeat (m_itemDropCount)
	{
		instance_create_depth(x,y, depth, m_itemDrop);
	}

	// do harvest effect & audio
	effectOnPlantHarvest(x, y);

	// update player stats
	var player = getPlayer();
	player.pstats.m_harvestedCrops[?kCropId_AllCrops] += 1;
	player.pstats.m_harvestedCrops[?object_index] += 1;

	if (exists(m_dirt))
	{
		m_dirt.planted = false;
		m_dirt.tilled = false;
		//m_dirt.watered = false;
		m_dirt.m_sprIndexUntilled = choose(2, 3, 4, 5);
	}

	delete(this);
}