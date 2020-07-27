#region Scriptable States

#macro kAiStyle_Default 0
#macro kAiStyle_Scripted 1
#macro kAiStyle_Follow 2
#macro kAiStyle_Lead 3
#macro kAiStyle_Custom 11

#macro kAiRequestCommand_Start 0
#macro kAiRequestCommand_Stop 1
#macro kAiRequestCommand_Animation 2
#macro kAiRequestCommand_Move 3
#macro kAiRequestCommand_Teleport 4
#macro kAiRequestCommand_Face 5
#macro kAiRequestCommand_FollowPath 6
#macro kAiRequestCommand_Jump 7

m_aiScript_style = kAiStyle_Default;
kAiScriptDefaultStyle = kAiStyle_Default;

m_aiScript_requestStyle = null;
m_aiScript_requestCommand = null;
m_aiScript_requestPositionX = 0;
m_aiScript_requestPositionY = 0;
m_aiScript_requestAnimation = null;
m_aiScript_requestAnimationLoop = false;
m_aiScript_requestSpeed = 0;
m_aiScript_requestPathnode = null;

m_aiScript_wallTimer = 0.0;
m_aiScript_wallBashCount = 0;

m_aiScript_pathTimer = 0.0;

m_aiScript_jumpTimer = 0.0;
m_aiScript_jumpDistance = 0.0;
m_aiScript_jumpStartX = 0;
m_aiScript_jumpStartY = 0;
m_aiScript_jumpStartZ = 0;
m_aiScript_jumpTargetZ = 0;

aipathInit();

aiFollowerInit();
aiLeaderInit();
aiCustomInit();
aicommonCombatInit();

#endregion