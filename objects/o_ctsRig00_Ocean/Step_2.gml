/// @description Update the ocean mesh

// update the waves:

for (idx = 0; idx < kHeightfieldDim - 1; ++idx)
{
	for (idy = 0; idy < kHeightfieldDim - 1; ++idy)
	{
		m_heightfield[idx + idy * kHeightfieldDim] = 
			sin(Time.time * 1.2 + idx * 0.7 + idy * 0.7) * 1.0
			+ sin(Time.time * 1.6 + idx * 1.8 + idy * 0.3) * 1.0
			+ sin(Time.time * 1.7 + idx * 2.1 + idy * 3.1) * 1.0;
	}
}

// update the mesh:

var kMinX = -340;
var kMinY = -340;
var kMaxX = 340;
var kMaxY = 340;

vertex_begin(m_mesh, m_vformat);

var kTotalX = kMaxX - kMinX;
var kTotalY = kMaxY - kMinY;
var kQuadSizeX = kTotalX / (kHeightfieldDim - 1);
var kQuadSizeY = kTotalY / (kHeightfieldDim - 1);

for (idx = 0; idx < kHeightfieldDim - 1; ++idx)
{
	for (idy = 0; idy < kHeightfieldDim - 1; ++idy)
	{
		var t_x_min = kMinX + idx * kQuadSizeX;
		var t_y_min = kMinY + idy * kQuadSizeY;
		var t_x_max = kMinX + (idx + 1) * kQuadSizeX;
		var t_y_max = kMinY + (idy + 1) * kQuadSizeY;
		
		var z_00 = m_heightfield[idx + idy * kHeightfieldDim];
		var z_10 = m_heightfield[(idx + 1) + idy * kHeightfieldDim];
		var z_01 = m_heightfield[idx + (idy + 1) * kHeightfieldDim];
		var z_11 = m_heightfield[(idx + 1) + (idy + 1) * kHeightfieldDim];
		
		// tri 0
		vertex_position_3d(m_mesh, t_x_min, t_y_min, z_00);
		vertex_color(m_mesh, c_white, 1.0);
		vertex_texcoord(m_mesh, 0.0, 0.0);
		vertex_normal(m_mesh, 0, 0, 1);
	
		vertex_position_3d(m_mesh, t_x_min, t_y_max, z_01);
		vertex_color(m_mesh, c_white, 1.0);
		vertex_texcoord(m_mesh, 0.0, 1.0);
		vertex_normal(m_mesh, 0, 0, 1);
	
		vertex_position_3d(m_mesh, t_x_max, t_y_min, z_10);
		vertex_color(m_mesh, c_white, 1.0);
		vertex_texcoord(m_mesh, 1.0, 0.0);
		vertex_normal(m_mesh, 0, 0, 1);
	
		// tri 1
		vertex_position_3d(m_mesh, t_x_max, t_y_min, z_10);
		vertex_color(m_mesh, c_white, 1.0);
		vertex_texcoord(m_mesh, 1.0, 0.0);
		vertex_normal(m_mesh, 0, 0, 1);
	
		vertex_position_3d(m_mesh, t_x_min, t_y_max, z_01);
		vertex_color(m_mesh, c_white, 1.0);
		vertex_texcoord(m_mesh, 0.0, 1.0);
		vertex_normal(m_mesh, 0, 0, 1);
	
		vertex_position_3d(m_mesh, t_x_max, t_y_max, z_11);
		vertex_color(m_mesh, c_white, 1.0);
		vertex_texcoord(m_mesh, 1.0, 1.0);
		vertex_normal(m_mesh, 0, 0, 1);
	}
}


vertex_end(m_mesh);