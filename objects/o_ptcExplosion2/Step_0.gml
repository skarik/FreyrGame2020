/// @description animate

animationIndex += Time.deltaTime * 18;
image_index = animationIndex;
if (animationIndex >= image_number)
{
	idelete(this);
}