/// @description second init (onHurt)

switch ( m_damageType )
{
case kDamageTypeTar:
    if ( image_alpha > 0.9 && filltimer < 50 ) {
        image_alpha += choose(0,random(0.03),0.1);
    }
    break;
default:
    image_alpha += 0.3;
    break;
};