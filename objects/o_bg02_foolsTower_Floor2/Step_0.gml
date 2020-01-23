/// @description Create particle effects

//particle_counter += Time.dt * (room_width * room_height / 3000.0);
particle_counter += Time.dt * (GameCamera.width * GameCamera.height / 3000.0);
while (particle_counter > 0)
{
    //instance_create(random_range(0,room_width), random_range(0,room_height), fxDustHover);
	var random_x = GameCamera.view_x + random(GameCamera.width);
	var random_y = min(y, GameCamera.view_y + GameCamera.height) - random(GameCamera.height);
	instance_create_depth(random_x, random_y, -floor(room_height / 2.0), o_ptcMagidustHover);
    particle_counter -= 1.0;
}

// might as well handle overcharge here
with (o_potEnergy)
{
	if (y < other.y) {
		overcharge = min(2.0, overcharge + Time.deltaTime);
	}
	else {
		overcharge = saturate(overcharge - Time.deltaTime * 2.0);	
	}
}