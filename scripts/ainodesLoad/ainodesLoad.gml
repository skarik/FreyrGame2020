/// @function ainodesLoad(id, [force_rebuild])
/// @desc Loads up all nodes 
/// @param Node
/// @param force_rebuild
function ainodesLoad() {

#macro REBUILD_NODEGRAPH_ON_DATE false
#macro REBUILD_NODEGRAPH_ON_MISSING_DATA true

#macro kNodegraphFile_Header "NODE"
#macro kNodegraphFile_Version 4

	var node = argument[0];
	var forced_rebuild = (argument_count == 2) ? argument[1] : false;

	if (!directory_exists("nodegraphs"))
		directory_create("nodegraphs");

	var filename_nodegraph = "nodegraphs/" + string_replace(room_get_name(room),"rm_","");
	var save_to_file_enabled = true;

	// Ignore saving nodegraph on certain items
	if (!file_exists(filename_nodegraph))
	{
		if (room == rm_test_aiplayground)
		{
			save_to_file_enabled = false;
		}
	}
	// If nodegraph file exists, load it in
	else if (!forced_rebuild)
	{
		var buffer_nodegraph = buffer_load(filename_nodegraph);
	
		{
			// Read & check the header first
			var nodegraph_version = savestateCheckBufferHeader(buffer_nodegraph, kNodegraphFile_Header);
			if (nodegraph_version != kNodegraphFile_Version)
			{
				debugOut("Nodegraph: old version.");
				show_debug_message("Nodegraph: old version.");
			
				// Old nodegraph - rebuild.
				buffer_delete(buffer_nodegraph);
				file_delete(filename_nodegraph);
				ainodesLoad(node, true);
				return false;
			}
			// Read the build-date next
			var nodegraph_builddate = buffer_read(buffer_nodegraph, buffer_f64);
			if (REBUILD_NODEGRAPH_ON_DATE && nodegraph_builddate < GM_build_date && (GM_build_date - nodegraph_builddate > 0.1))
			{
				var l_dbgInfo = "Nodegraph: check (" + string(nodegraph_builddate) +") vs (" + string(GM_build_date) + ")";
				debugOut(l_dbgInfo);
				show_debug_message(l_dbgInfo);
			
				// Old nodegraph - rebuild.
				buffer_delete(buffer_nodegraph);
				file_delete(filename_nodegraph);
				ainodesLoad(node, true);
				return false;
			}
		}
	
		var node_count = buffer_read(buffer_nodegraph, buffer_u32);
	
		for (var i = 0; i < node_count; ++i)
		{
			var node_index = buffer_read(buffer_nodegraph, buffer_u64);
			var node_id = instance_find(ob_aiNode, node_index);
			if (!iexists(node_id) || object_get_base_parent(node_id.object_index) != ob_aiNode)
			{	
				debugOut("Nodegraph: invalid for this room.");
				show_debug_message("Nodegraph: invalid for this room.");
			
				// Invalid data! Clean up and return
				with (ob_aiNode)
				{
					m_link = [];
					m_link_type = [];
					m_valid = false; // Mark all nodes as invalid
					m_loaded = false;
				}
				buffer_delete(buffer_nodegraph);
				file_delete(filename_nodegraph);
				ainodesLoad(node, true);
				return false;
			}
			else
			{
				// Load in node link info
				var node_linkcount = buffer_read(buffer_nodegraph, buffer_u32);
				for (var ilink = 0; ilink < node_linkcount; ++ilink)
				{
					var c_link = buffer_read(buffer_nodegraph, buffer_u64);
					var c_type = buffer_read(buffer_nodegraph, buffer_u32);
				
					var c_link_instance = instance_find(ob_aiNode, c_link);
					if (!iexists(c_link_instance))
					{
						with (ob_aiNode)
							m_valid = false; // Mark all nodes as invalid
						return false;
					}
				
					node_id.m_link[ilink] = c_link_instance;
					node_id.m_link_type[ilink] = c_type;
				}
			
				// mark node as loaded & valid
				node_id.m_loaded = true;
				node_id.m_valid = true;
			}
		}
		// All the nodes are now loaded
	
		// Check that all nodes are loaded
		if (REBUILD_NODEGRAPH_ON_MISSING_DATA)
		{
			with (ob_aiNode)
			{
				if (!m_loaded || !m_valid)
				{
					debugOut("Nodegraph: incomplete for this room.");
					show_debug_message("Nodegraph: incomplete for this room.");
		
					buffer_delete(buffer_nodegraph);
					file_delete(filename_nodegraph);
					ainodesLoad(node, true);
					return false;
				}
			}
		}
	
		buffer_delete(buffer_nodegraph);
	}

	// regen, and save
	if (forced_rebuild || 
		((!node.m_loaded || !node.m_valid) && !file_exists(filename_nodegraph)))
	{
		debugOut("Nodegraph out of date. Rebuilding...");
		show_debug_message("Nodegraph out of date. Rebuilding...");
	
		with (ob_aiNode)
		{
			ainodesLink(id);
		
			m_valid = true;
			m_loaded = true;
		}
	
		show_debug_message("Rebuilding done.");
	
		if (save_to_file_enabled)
		{
			// Generate the node listing used - instance_find() stays constant between shit
			var node_instance_listing = [];
			for (var i = 0; i < instance_number(ob_aiNode); ++i)
			{
				node_instance_listing[i] = instance_find(ob_aiNode, i);
			}
		
			// Record all node information
			var buffer_nodegraph = buffer_create(1024, buffer_grow, 1);
		
			// Write the header
			savestateWriteBufferHeader(buffer_nodegraph, kNodegraphFile_Header, kNodegraphFile_Version);
		
			// Write the date first.
			buffer_write(buffer_nodegraph, buffer_f64, GM_build_date);
	
			var node_count = instance_number(ob_aiNode);
			buffer_write(buffer_nodegraph, buffer_u32, node_count);
			for (var i = 0; i < node_count; ++i)
			{
				var node_id = instance_find(ob_aiNode, i);
				buffer_write(buffer_nodegraph, buffer_u64, i);
		
				var node_linkcount = array_length_1d(node_id.m_link);
				buffer_write(buffer_nodegraph, buffer_u32, node_linkcount);
				for (var ilink = 0; ilink < node_linkcount; ++ilink)
				{
					//buffer_write(buffer_nodegraph, buffer_u64, node_id.m_link[ilink]);
					buffer_write(buffer_nodegraph, buffer_u64, array_get_index(node_instance_listing, node_id.m_link[ilink]));
					buffer_write(buffer_nodegraph, buffer_u32, node_id.m_link_type[ilink]);
				}
			}
	
			buffer_save(buffer_nodegraph, filename_nodegraph + ".nodegraph");
			buffer_delete(buffer_nodegraph);
		}
	}
	// mark all nodes as loaded as we load em
	/*else if ((!node.m_loaded || !node.m_valid))
	{
	
	}*/
	/*else
	{
		// Invalid state. Should never get here.
		show_error("Invalid buffer state with nodes.", true);
	}*/

	return true;


}
