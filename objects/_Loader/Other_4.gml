new(System);
new(Screen);
new(GameCamera);
new(Time);
new(Debug);
new(Settings);
new(Game);

// Update persistance
System.persistent = true;
Screen.persistent = true;
GameCamera.persistent = true;
Debug.persistent = true;
Settings.persistent = true;

// Update layers
Screen.layer = System.layer;
GameCamera.layer = System.layer;
Debug.layer = System.layer;
Settings.layer = System.layer;

// Load fonts
fontsLoad();

// Loop through each room and set the views
var t_currentRoom = room_first;
while (room_exists(t_currentRoom))
{
	if (t_currentRoom != room)
	{
		room_set_view_enabled(t_currentRoom, true);
		// Set game viewport
		room_set_viewport(t_currentRoom, 0,
			true,
			0, 0, Screen.width / Screen.pixelScale, Screen.height / Screen.pixelScale);
		//room_set_camera(t_currentRoom, 0, GameCamera.index);
		// Set window viewport
		room_set_viewport(t_currentRoom, 1,
			false,
			0, 0, Screen.width, Screen.height);
		// We use raw cameras instead of views, now.
	}
	t_currentRoom = room_next(t_currentRoom);
}

// Update the window
window_set_size(Screen.width, Screen.height);
//surface_resize(application_surface, Screen.width, Screen.height);
window_set_position(128,128);

// Output some debug info
debugOut("working_directory: " + working_directory);
debugOut("program_directory: " + program_directory);

// Finish and go to next room
room_goto_next();