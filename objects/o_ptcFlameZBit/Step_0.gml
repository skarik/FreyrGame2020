/// @description animation

// animation
animationIndex += Time.deltaTime * 20 * animationSpeed;
image_index = animationIndex;
if (animationIndex >= image_number)
{
	idelete(this);
	exit;
}

