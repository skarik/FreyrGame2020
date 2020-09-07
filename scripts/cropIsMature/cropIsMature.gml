/// @function cropIsMature(crop)
/// @desc Is the crop actually mature and ready for farming?
/// @param crop {Object} Crop to check maturity.
function cropIsMature(argument0) {
	var crop = argument0;
	return (crop.m_growValue >= crop.m_growAmountMature);


}
