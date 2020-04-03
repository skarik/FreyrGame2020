/// @description Kill after 0.5 seconds

time += Time.unscaledDeltaTime;
if (time > 0.5)
	delete(this);