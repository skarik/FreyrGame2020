/// @description stats load

m_name = "Cortez";
m_body = 0;
m_head = 0;
m_gender = kGenderMale;

#macro kGenderFemale 0
#macro kGenderMale 1 
#macro kGenderNonbi 2

#macro kPitemGrapple 0
#macro kPitemVoidCapacitor 1
#macro kPitemVoidAlternator 2
#macro kPitem_MAX 16

for (var i = 0; i < kPitem_MAX; ++i)
{
	m_pitem[i] = 0;
}

m_fortune = null;