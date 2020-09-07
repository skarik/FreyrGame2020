function playerUiDrawBottomRightMap() {
	var pl = getPlayer();
	var dx, dy;

	// draw map for this area
	if (0)
	{
		dx = round(GameCamera.width * 0.8);
		dy = round(GameCamera.height * 0.7);
	
		// get center of map
		var room_info = map.rooms_info[room];
		var room_info_min = room_info[0];
		var room_info_max = room_info[1];
		var room_info_center = [
			(room_info_min[0] + room_info_max[0]) * 0.5, 
			(room_info_min[1] + room_info_min[1]) * 0.5
			];
		
		// get position of player
		var pl_pos_percent = [
			pl.x / room_width,
			pl.y / room_height
			];
		var pl_pos_grid = [
			room_info_min[0] + (room_info_max[0] - room_info_min[0]) * pl_pos_percent[0],
			room_info_min[1] + (room_info_max[1] - room_info_min[1]) * pl_pos_percent[1]
			];
		
		// select the map bounds from the center
		var kHalfDiv = 5.0;
		var map_start = [
			round(room_info_center[0] - kHalfDiv),
			round(room_info_center[1] - kHalfDiv)
			];
		var map_end = [
			map_start[0] + kHalfDiv * 2.0,
			map_start[1] + kHalfDiv * 2.0
			];
		var map_center = [
			(map_start[0] + map_end[0]) * 0.5,
			(map_start[1] + map_end[1]) * 0.5
			];
		
		// grid constants
		var kGridW = 10.0;
		
		// draw the map from the bounds
		draw_set_color(merge_color(c_gold, c_dkgray, 0.5));
		draw_set_alpha(0.5);
		for (var ix = map_start[0]; ix <= map_end[0]; ++ix)
		{
			for (var iy = map_start[1]; iy <= map_end[1]; ++iy)
			{
				var v_ix = ix - map_center[0];
				var v_iy = iy - map_center[1];
			
				var room_id = map.map[ix + iy * map.map_width];
				if (room_id != null)
				{
					draw_rectangle(
						dx +  v_ix      * kGridW, dy +  v_iy      * kGridW,
						dx + (v_ix + 1) * kGridW, dy + (v_iy + 1) * kGridW,
						false);
				}
			}
		}
		// draw the curret room
		draw_set_color(c_white);
		draw_set_alpha(1.0);
		draw_rectangle(
			dx + (room_info_min[0] - map_center[0]) * kGridW,
			dy + (room_info_min[1] - map_center[1]) * kGridW,
			dx + (room_info_max[0] - map_center[0]) * kGridW,
			dy + (room_info_max[1] - map_center[1]) * kGridW,
			true
			);
	
		// todo: draw the current subroom
	
		// draw player position
		draw_set_color(c_red);
		draw_circle(
			dx + (pl_pos_grid[0] - map_center[0]) * kGridW,
			dy + (pl_pos_grid[1] - map_center[1]) * kGridW,
			2, false);
	}


}
