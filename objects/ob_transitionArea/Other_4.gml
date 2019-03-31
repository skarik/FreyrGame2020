if (global._transition_source != null)
{
    // Find matching room
    if (target == global._transition_source)
    {
        var pos_x = x;
        var pos_y = y;
        with (getPlayer())
        {   
            // Skip invalid players
            if (m_isPlayer == false) continue;
            
            if (pos_x <= 0) {
                x = pos_x + 2;
            }
            else if (pos_x >= room_width) {
                x = pos_x - 2;
            }
            else {
                x = pos_x;
            }
			if (pos_y <= 0) {
                y = pos_y + 2;
            }
            else if (pos_y >= room_width) {
                y = pos_y - 2;
            }
            else {
                y = pos_y;
            }
			x += global._transition_dx;
            y += global._transition_dy;
            
            persistent = false;
            inventory.persistent = false;
        }
        with (o_PlayerHud)
        {
            persistent = false;
        }
        
        global._transition_source = null;
    }
}

