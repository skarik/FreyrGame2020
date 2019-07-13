/// @description draw radius

radius += growSpeed * Time.deltaTime;
growSpeed = max(0.0, growSpeed - slowAccel * Time.deltaTime);

if (growSpeed < fadePoint)
	image_alpha -= fadeSpeed * Time.deltaTime;
	
if (image_alpha < 0.0)
	delete(this);