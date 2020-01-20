/// @description Insert description here
// You can write your code in this editor

//particle_counter += Time.dt * (room_width * room_height / 3000.0);
particle_counter += Time.dt * (GameCamera.width * GameCamera.height / 3000.0);
while (particle_counter > 0)
{
    //instance_create(random_range(0,room_width), random_range(0,room_height), fxDustHover);
	var random_x = GameCamera.view_x + random(GameCamera.width);
	var random_y = min(y, GameCamera.view_y + GameCamera.height) - random(GameCamera.height);
	instance_create_depth(random_x, random_y, -10, o_ptcMagidustHover);
    particle_counter -= 1.0;
}
