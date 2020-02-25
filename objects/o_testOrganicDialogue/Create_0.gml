/// @description do not make this similar to cutscene code.
// put this under scripting

//alarm[0] = 60;

m_running = false;			// Are lines currently running?
m_lineIndex = 0;			// Current work main state.
m_executeState = 0;			// Current work substate.

m_lineCount = 0;			// How many lines exist? Recalculated on trigger.
m_mainLinesDone = false;	// Are the main vox-lines finished?