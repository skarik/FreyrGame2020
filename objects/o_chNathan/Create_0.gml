/// @description options

if (singleton_this()) exit;

#region Per Follower Info

m_name = "Nathan";
m_interactChoices = 4;
m_interaction[0] = "Hello!";
m_interaction[1] = "Stay here.";
m_interaction[2] = "(Crafting)";
m_interaction[3] = "(Leave)";
m_interactionFile = "talk00_nathan.txt";

#endregion

// Perform the common init
event_inherited();

#region Post-init

m_team = kTeamGood;

aiScriptableInit();
aiFollowerInit();
aiLeaderInit();

// override default following: we want to follow
//m_aiFollowing = true;
m_isFollower = true;

#endregion

kAnimStanding = s_charNathanStand;
kAnimWalking = s_charNathanWalk;