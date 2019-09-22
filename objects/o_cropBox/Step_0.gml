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
	//Handle the daily trade
	for (var i = 0; i < inventoryGetCount(m_inventory); i++)
	{
		if	(exists(m_inventory.item[i]) && m_inventory.item[i].object != null)
		{
			 var item = farmPlaceReturnItem(m_inventory.item[i]);	
			 if (item != null)
			 {
				m_inventory.item[i] = item;
			 }
		}
	}
}