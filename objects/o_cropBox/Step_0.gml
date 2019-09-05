/// @description Insert description here
// You can write your code in this editor

var currentTime = timeofdayGetHour();
if (m_dailyPickup == true && currentTime < 1)
{
	m_dailyPickup = false;	
}

if (m_dailyPickup == false && currentTime > 8)
{
	m_dailyPickup = true;
	
	//Empty the inventory for now. It will eventually have to go to a secondary 
	itemArrayFree(m_inventory.item);
}