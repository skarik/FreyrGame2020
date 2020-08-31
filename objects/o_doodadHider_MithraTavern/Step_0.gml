/// @description Update fading & nighttime sprite

// Inherit the parent event
event_inherited();

image_index = timeofdayIsDaytime() ? 0 : 1;

var fade_out;
var pl = getPlayer();
//if (pl.x > bbox_left && pl.x < bbox_right && pl.y < bbox_bottom && pl.y > bbox_top + 100)
//if (pl.x > bbox_left && pl.x < bbox_right && pl.y < bbox_bottom && pl.y > bbox_top)
if (pl.x > bbox_left - 8 && pl.x < bbox_right + 8 && pl.y < bbox_bottom && pl.y > bbox_top - (16*8))
{
	fade_out = true;
}
else
{
	fade_out = false;
}


// Fade in and out
if (fade_out)
{
	image_alpha -= 3.0 * Time.deltaTime;
}
else
{
	image_alpha += 3.0 * Time.deltaTime;
}
image_alpha = saturate(image_alpha);
visible = (image_alpha >= 0.01);

fader.image_alpha = (1.0 - image_alpha) * 1.0;
fader.visible = (fader.image_alpha >= 0.01);
faderUpper.image_alpha = fader.image_alpha;
faderUpper.visible = fader.visible;