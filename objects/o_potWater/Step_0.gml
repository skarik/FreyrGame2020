/// @description Depth update

depthUpdate();

if (filled)
{
	if (charges <= 0)
	{
		filled = false;
		image_index = 0;
	}
	else
	{
		image_index = 1;
		m_name = "Water Pot (" + string(charges) + "/" + string(kMaxCharges) + ")";
	}
}
else
{
	image_index = 0;
	m_name = "Empty Water Pot";
}

if (charges > 0)
{
	var dx = floor(x / 16) * 16 + 8;
	var dy = floor(y / 16) * 16 + 8;
	
	var till_square = collision_point(dx, dy, o_fieldSquare, false, true);
	if (iexists(till_square))
	{
		if (!till_square.watered)
		{
			till_square.watered = true;
			charges -= 1;
			
			var audio;
			// Make water sound
			audio = sound_play_at(x, y, "audio/npc/water_block.wav");
			audio.pitch = random_range(1.00, 1.30);
			audio.gain = random_range(0.2, 0.3);
			audio.falloff_start = 20;
			audio.falloff_end = 500;
			audio.falloff_factor = 1;
			audio.parent = id;
			// Make water sound
			audio = sound_play_at(x, y, "audio/phys/step_water1.wav");
			audio.pitch = random_range(1.20, 1.40);
			audio.gain = random_range(0.6, 0.7);
			audio.falloff_start = 20;
			audio.falloff_end = 500;
			audio.falloff_factor = 1;
			audio.parent = id;
		}
	}
}

// fill with water
var inWater = areaInWater(x, y, -128);
filled = filled || inWater;
if (inWater)
{
	if (charges < kMaxCharges)
	{
		charges = kMaxCharges;
		
		// Make water sound
		audio = sound_play_at(x, y, "audio/item/waterjug_fill.wav");
		audio.pitch = random_range(0.9, 1.10);
		audio.gain = random_range(0.6, 0.7);
		audio.falloff_start = 30;
		audio.falloff_end = 600;
		audio.falloff_factor = 1;
		audio.parent = id;
	}
}
