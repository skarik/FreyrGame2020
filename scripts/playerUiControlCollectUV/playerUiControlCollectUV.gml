/// @function playerUiControlCollectUV
/// @desc Collects the player UV control stuff
var prevAxis = [o_PlayerTest.uAxis.previous, o_PlayerTest.vAxis.previous];
var currAxis = [o_PlayerTest.uAxis.value, o_PlayerTest.vAxis.value];
			
var prevAxisMagnitude = avec2_length(prevAxis);
var currAxisMagnitude = avec2_length(currAxis);
		
var prevAxisNormalized = avec2_divide(prevAxis, prevAxisMagnitude);
var currAxisNormalized = avec2_divide(currAxis, currAxisMagnitude);
		
var axisDirectionChange = avec2_dot(prevAxisNormalized, currAxisNormalized);

return [prevAxis, currAxis, prevAxisMagnitude, currAxisMagnitude, prevAxisNormalized, currAxisNormalized, axisDirectionChange];