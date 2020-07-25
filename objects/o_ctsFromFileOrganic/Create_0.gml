/// @description Create cutscene based on file & set optional params

event_inherited();

//cutsceneLoad(m_cutsceneFile); // Done in parent
cutsceneSetActorList(m_actors);
cutsceneJumpToLabel("OnEnd"); // Jump to end immediately.


m_triggered = false;
m_interruptedNearby = false;
m_interruptedAlert = false;
m_interruptedAngry = false;