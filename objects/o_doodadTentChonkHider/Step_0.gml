/// @description Update fading

// Inherit the parent event
event_inherited();

var fade_out;
var pl = getPlayer();
if (place_meeting(x, y, pl))
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