currentUsable = null;
currentHeldUsable = null;
m_isHolding = false;

currentCrop = null;
currentTillable = null;
currentBuildable = false;
currentBuildableX = 0;
currentBuildableY = 0;

m_isTilling = false;
m_till_filldirt = false;
m_till_target = null;
m_till_timer = 0.0;
m_till_timedirt = 0.5;
m_till_time = 0.3;
m_till_x = 0;
m_till_y = 0;

m_isPlanting = false;
m_plantable = false;
m_plant_dirt = null;
m_isPlanting = false;
m_plant_x = 0;
m_plant_y = 0;
m_plant_timer = 0.0;
m_plant_time = 0.3;

m_isHarvesting = false;
m_harvest_timer = 0.0;
//m_harvest_time = 5.0 / 60.0;
m_harvest_time = 20.0 / 60.0;
m_harvest_target = null;

m_isVoidPunchCharging = false; //TODO: reuse for other key items
m_voidPunch_fill = 1.0;
m_voidPunch_charged = 0.0;

aimingDirection = 0.0;
aimingHeight = 11;
aimingStartX = x;
aimingStartY = y;

aiming2Direction = 0.0;
aiming2Height = 1;
aiming2StartX = x;
aiming2StartY = y;

inCombatMode = false;

inDelayFrame = false;

m_usingBook = false;
m_usingInventory = false;
m_currentChest = null;

#macro kInteractionAttack 0 
#macro kInteractionUse 1
#macro kInteractionTill 2 
#macro kInteractionTill2 3
#macro kInteractionDefault -1

m_currentInteractionType = kInteractionAttack;