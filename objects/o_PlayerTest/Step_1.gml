/// @description Shake On Hurt

// Create screen shake on hurt effects
if ( m_isPlayer && stats.m_health < stats.m_healthPrev )
{
    var damage_gradient = (stats.m_healthPrev - stats.m_health) * (100 / stats.m_healthMax);
    effectScreenShake(
        1 + floor(damage_gradient * 0.25),
        0.3 + floor(damage_gradient) * 0.05,
        true);
    effectControllerShake(
        1.0,
        0.2 + floor(damage_gradient) * 0.03,
        true);
}

event_inherited();

