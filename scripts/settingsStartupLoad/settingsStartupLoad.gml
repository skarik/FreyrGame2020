with (Settings)
{
    ini_open("settings.ini");
    
	startup_roomOverride	= ini_read_string("startup", "override", "");
	startup_roomOverride	= room_get_index(startup_roomOverride);
	
	startup_overrideSave	= ini_read_real("startup", "overridesave", false);
	
	startup_command			= ini_read_string("startup", "command", "");

    ini_close();
}

