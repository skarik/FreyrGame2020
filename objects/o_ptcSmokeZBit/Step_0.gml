/// @description animation

// animation
animationIndex += Time.deltaTime * 16 * animationSpeed;
image_index = animationIndex;
if (animationIndex >= image_number)
{
	idelete(this);
	exit;
}

// scroll up faster
y -= Time.deltaTime;