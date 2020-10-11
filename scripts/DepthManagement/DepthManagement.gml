function DepthState() constructor
{
	// Set current draw depth
	depth = 0;
	
	// Set default rendering routine
	worldDraw = depthWorldDrawSelf;
	
	// Set default shadow render routines
	shadowPredraw = depthShadowPredrawNone;
	shadowDraw = depthShadowDrawNone;
}

///@function depthInit()
function depthInit()
{
	z = 0; // The current ground.
	z_height = 0; // Distance from the Z.
	
	depth = 0;
	//layer = -1; // Set invalid layer
	
	m_depthState = new DepthState();
	
	// 1. Get speed numbers with the current rendering
	// 2. Get speed numbers with the new rendering as it is worked on.
	
	// Add item to the rendering list
	if (!iexists(DepthRenderer))
	{
		inew(DepthRenderer);
	}
	if (ds_list_find_index(DepthRenderer.m_objects, id) == -1)
	{
		ds_list_add(DepthRenderer.m_objects, id);
		DepthRenderer.m_objectsDirty = true;
	}
	
	depthUpdate(); // Force depth update now.
}

///@function depthUpdate()
function depthUpdate()
{
	var y_zero = y + z;
	
	//depth = -y / 2.0 - (z + z_height *  0.5) / 2.0;

	// depth = -(y_zero + z + z_height);
	//depth = -(y + z + z + z_height);
	
	// Save unbounded depth
	m_depthState.depth = -(y_zero + (z + z_height) / 2.0) / 2.0;
	
	// Set bounded depth
	depth = m_depthState.depth;
}

/// @function depthGetState()
/// @desc Returns the depth state structure, which holds callbacks & other states.
function depthGetState()
{
	return m_depthState();
}

/// @function depthSetWorldDrawFunction( function )
/// @param function
function depthSetWorldDrawFunction ( func )
{
	m_depthState.worldDraw = func;
}

/// @function depthSetShadowPredrawFunction( function )
/// @param function
function depthSetShadowPredrawFunction ( func )
{
	m_depthState.shadowPredraw = func;
}

/// @function depthSetShadowDrawFunction( function )
/// @param function
function depthSetShadowDrawFunction ( func )
{
	m_depthState.shadowDraw = func;
}