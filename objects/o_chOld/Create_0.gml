/// @description options

if (singleton_this()) exit;

#region Per Follower Info

m_name = "Old";
m_interactionFile = ""; //

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

#endregion

kAnimStanding = s_charViggoStand;
//kAnimWalking = s_charNathanWalk;