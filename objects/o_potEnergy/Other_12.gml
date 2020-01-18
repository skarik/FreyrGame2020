/// @description On put down

event_inherited();

/*var inWater = areaInWater(x, y, -128);

filled = filled || inWater;
if (inWater)
{
	charges = kMaxCharges;
}

image_index = filled ? 1 : 0;
m_name = filled ? "Full Water Pot" : "Empty Water Pot";*/

// Not placed in a power slot? Destroy self.
m_canPickUp = false;
energyFade = true;
m_name = "Decaying Energy Pot";
m_actionName = "";