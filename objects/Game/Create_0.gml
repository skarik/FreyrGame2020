if (singleton_this()) exit;

// Set up transition 
global._transition_source = null;
global._cutscene_main = null;

// Load up cutscene backend
cutsceneBackendLoad();