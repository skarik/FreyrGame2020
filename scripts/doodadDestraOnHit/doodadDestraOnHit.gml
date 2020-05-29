var source = argument0;
var c_x1 = argument1;
var c_y1 = argument2;
var c_x2 = argument3;
var c_y2 = argument4;

// Create hurt effect
var particle_type = doodadDestraHitParticleType();
if (particle_type != null)
{
	var particle_count = doodadDestraHitParticleCount();
	repeat (particle_count)
	{
		// Create particle here:
		var dx = random_range(c_x1, c_x2);
		var dy = random_range(c_y1, c_y2);
		var ddir = point_direction(source.x, source.y, dx, dy);
		var particle = instance_create_depth(dx, dy, depth, particle_type);
			particle.xspeed = lengthdir_x(random_range(40, 80), ddir);
			particle.yspeed = lengthdir_y(random_range(40, 80), ddir);
			particle.zspeed = random_range(40, 80);
			particle.z = z;
			particle.z_height = abs(sprite_height) * 0.33;
	}
}

if (m_health <= 0.0)
{
	// Create the drops on death
	var drops = doodadDestraGenerateDrops();
	if (drops != null)
	{
		for (var i = 0; i < array_length_1d(drops); ++i)
		{
			var drop = drops[i];
			if (drop != null && object_exists(drop))
			{
				instance_create_depth(x, y, depth, drop);
			}
		}
	}
	
	// Create death effect
	
	// Destoy self
	doodadDestraOnDestroy();
	idelete(this);
}
