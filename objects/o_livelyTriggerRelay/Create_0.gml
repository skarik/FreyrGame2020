/// @description Initial trigger state

#macro kTriggerByPlayer		0x01
#macro kTriggerByParty		0x02
#macro kTriggerByEnemy		0x04
#macro kTriggerByProjectile	0x08

event_inherited();

m_retriggerCountdown = -1.0;