/// @description draw under HUD

/*if ( last_damage == DAMAGE_DEATHTAR )
{
    draw_set_blend_mode_ext( bm_dest_color, bm_src_color );
}
*/
/*var prevalpha;
prevalpha = image_alpha;
if ( last_damage == DAMAGE_DEATHTAR )
{
    if ( image_alpha > 1.3 ) {
        image_alpha = (0.3-(image_alpha-1.3))/0.3;
    }
    else {
        image_alpha = min( image_alpha, 1.0 );
    }
}
*/
draw_sprite_ext( sprite_index, image_index, x, y, image_xscale,image_yscale, image_angle, image_blend, image_alpha );
/*if ( m_damageType == kDamageTypeTar )
{
    draw_sprite_ext(
        sprite_index, image_index,
        xstart+sin(current_time*0.008+id*1.17)*9, ystart+cos(current_time*0.009+id*1.11)*9,
        image_xscale,image_yscale,
        image_angle + sin( current_time*0.006+id*1.93 ) * 15,
        image_blend, image_alpha );
}*/
/*
draw_set_blend_mode( bm_normal );*/
/*
image_alpha = prevalpha;*/