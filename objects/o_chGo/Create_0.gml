/// @description options

if (singleton_this()) exit;

#region Per Follower Info

m_name = (questGetValue(kQidMithraEscape) >= 10) ? "Samuel" : "???";
m_interactionFile = ""; //
m_interactChoices = 0;

#endregion

// Perform the common init
event_inherited();

#region Post-init

m_team = kTeamGood;

aiScriptableInit();
aiFollowerInit();
aiLeaderInit();

// override default following: we want to follow
m_aiFollowing = false;
m_isFollower = false;
kAiFollowHideDuringCombat = true; // Definitely hide during combat

#endregion

kKickbackAmount = 1.0;

kMoveSpeed = 160;//120;
kMoveSpeedStunPercent = 0.05;
kMoveSpeedWaterPercent = 0.50;
kMoveSpeedTarPercent = 0.20;

kMoveAcceleration = 1000;//800;
kMoveAccelerationStop = 600;//500;
kMoveAccelerationAir = 200;
kMoveAccelerationAirStop = 10;

//kAnimStanding = s_charViggoStand;
//kAnimWalking = s_charNathanWalk;
