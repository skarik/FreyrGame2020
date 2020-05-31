/// @function ainodesLoad(id)
/// @desc Loads up all nodes 

var node = argument0;

if (!directory_exists("nodegraphs"))
	directory_create("nodegraphs");
	
var filename_nodegraph = "nodegraphs/" + string_replace(room_get_name(room),"rm_","");
	
// regen, and save
if (!node.m_valid || !file_exists(filename_nodegraph))
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
	
	// Record all node information
	var buffer_nodegraph = buffer_create(1024, buffer_grow, 1);
	
	var node_count = instance_number(ob_aiNode);
	buffer_write(buffer_nodegraph, buffer_u32, node_count);
	for (var i = 0; i < node_count; ++i)
	{
		var node_id = instance_find(ob_aiNode, i);
		buffer_write(buffer_nodegraph, buffer_u64, node_id);
		
		var node_linkcount = array_length_1d(node_id.m_link);
		buffer_write(buffer_nodegraph, buffer_u32, node_linkcount);
		for (var ilink = 0; ilink < node_linkcount; ++ilink)
		{
			buffer_write(buffer_nodegraph, buffer_u64, node_id.m_link[ilink]);
			buffer_write(buffer_nodegraph, buffer_u32, node_id.m_link_type[ilink]);
		}
	}
	
	buffer_save(buffer_nodegraph, filename_nodegraph);
	buffer_delete(buffer_nodegraph);
}
// mark all nodes as loaded as we load em
else
{
	var buffer_nodegraph = buffer_load(filename_nodegraph);
	
	var node_count = buffer_read(buffer_nodegraph, buffer_u32);
	for (var i = 0; i < node_count; ++i)
	{
		var node_id = buffer_read(buffer_nodegraph, buffer_u64);
		if (!iexists(node_id))
		{
			with (ob_aiNode)
				m_valid = false; // Mark all nodes as invalid
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
				
				if (!iexists(c_link))
				{
					with (ob_aiNode)
						m_valid = false; // Mark all nodes as invalid
					return false;
				}
				
				node_id.m_link[ilink] = c_link;
				node_id.m_link_type[ilink] = c_type;
			}
			
			// mark node as loaded & valid
			node_id.m_loaded = true;
			node_id.m_valid = true;
		}
	}
	// All the nodes are now loaded
	
	buffer_delete(buffer_nodegraph);
}


/*with (ob_aiNode)
{
	m_loaded = true;
	m_valid = true;
}*/

return true;