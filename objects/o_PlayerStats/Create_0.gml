/// @description stats load

m_name = "Cortez";
m_body = 0;
m_head = 0;
m_gender = kGenderMale;
m_shirtless = false;

#macro kGenderFemale 0
#macro kGenderMale 1 
#macro kGenderNonbi 2

#macro kPitemGrapple 0
#macro kPitemVoidCapacitor 1
#macro kPitemVoidAlternator 2
#macro kPitemLantern 3
#macro kPitem_MAX 16

for (var i = 0; i < kPitem_MAX; ++i)
{
	m_pitem[i] = 0;
}

m_fortune = array_create(0);
m_fortune_flipped = false;


#macro kHazardRoboVoidShot 0
#macro kHazard_MAX 256

m_hazards = array_create(kHazard_MAX, 0);