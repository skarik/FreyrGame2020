/// @description actual init
switch ( m_damageType )
{
case kDamageTypeTar:
    //sprite_index = sprHudHurtDeathtar;
	image_blend = c_dkgray; // temp hack
    
    image_angle = random( 360 );
    image_speed = 0;
    image_index = floor( random( image_number ) );
	image_alpha = 2.0;
    
    image_xscale = random( 0.2 ) + 0.8;
    image_yscale = random( 0.2 ) + 0.8;
    image_xscale *= choose(1,-1);
    
    x += (160-x)*(0.03+random(0.08));
    y += (120-y)*(0.03+random(0.08));
    break;
	
case kDamageTypeBite:
    //sprite_index = sprHudHurtClawEffect;

    image_angle = random( 360 );
    image_speed = 0;
    image_index = floor( random( image_number ) );
	image_alpha = 5.0;
    
    image_xscale = random( 0.1 ) + 0.9;
    image_yscale = random( 0.1 ) + 0.9;
    
    x += (160-x)*0.06;
    y += (120-y)*0.06;
    break;
	
case kDamageTypePiercing:
default:
    sprite_index = spt_bloodHud;

    image_angle = random( 360 );
    image_speed = 0;
    image_index = floor( random( image_number ) );
	image_alpha = 11.0;
    
    image_xscale = random( 0.2 ) + 0.7;
    image_yscale = random( 0.2 ) + 0.7;
    break;
};

xstart = x;
ystart = y;