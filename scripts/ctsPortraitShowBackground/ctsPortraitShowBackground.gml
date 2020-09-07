/// @description ctsPortraitShowBackground(sprite)
/// @param sprite
function ctsPortraitShowBackground(argument0) {

	var sprite = argument0;

	if (!iexists(o_CtsPortraitRenderer))
		inew(o_CtsPortraitRenderer);
	
	var portrait_renderer = o_CtsPortraitRenderer;
	with (portrait_renderer)
	{
		if (sprite == null)
		{
			params_background = null;
			params_background_alpha = 0.0;
		}
		else
		{
			params_background = sprite;
			params_background_alpha = 1.0;
		}
	}


}
