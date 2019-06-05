// update cutscene blend
if (m_inCutscene)
	m_inCutsceneBlend += Time.deltaTime * 0.8;
else
	m_inCutsceneBlend -= Time.deltaTime * 0.8;
m_inCutsceneBlend = saturate(m_inCutsceneBlend);

if (m_inCutsceneBlend < 1.0)
{
	playerUiUpdateBook();
	playerUiUpdateInventory();
	playerUiUpdateBag();
	playerUiUpdateChest();

	playerUiUpdateInventoryManagement();
}