/// @description fade bheaviors
if ( image_alpha > 12.8 ) {
    image_alpha = 12.8;
}

filltimer += 1;

switch ( m_damageType )
{
case kDamageTypeTar:
    image_alpha -= 0.04 * Time.deltaTime * 30;
    x = xstart - (160-xstart)*0.11*(1.6-image_alpha);
    y = ystart - (120-ystart)*0.11*(1.6-image_alpha);
    image_blend = merge_color( image_blend, merge_color( c_white,c_black,saturate(image_alpha/1.6) ), 0.5 );
    break;
	
case kDamageTypeBite:
    image_alpha -= 0.017 * Time.deltaTime * 30;
    break;
	
default:
    image_alpha -= 2.4 * Time.deltaTime;
    break;
};

if ( image_alpha <= 0 ) {
    delete( this );
}

