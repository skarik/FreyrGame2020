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

//kAnimStanding = s_charViggoStand;
//kAnimWalking = s_charNathanWalk;