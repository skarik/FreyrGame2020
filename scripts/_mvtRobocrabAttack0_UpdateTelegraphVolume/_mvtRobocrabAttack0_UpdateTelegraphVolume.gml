var verts = atkwarnShapeGetVertices(m_meleeTelegraphVolume);
var indices = atkwarnShapeGetIndices(m_meleeTelegraphVolume);
		
// draw the damage sectors
var vertex;
for (var i = 0; i < 4; ++i)
{
	vertex = array_create(4);
	vertex[0] = x + lengthdir_x(beamAtkWidth, aimingDirection - 90) + lengthdir_x(beamAtkRanges[i], aimingDirection - beamAtkAngleOff);
	vertex[1] = y + lengthdir_y(beamAtkWidth, aimingDirection - 90) + lengthdir_y(beamAtkRanges[i], aimingDirection - beamAtkAngleOff);
	vertex[2] = c_white;
	vertex[3] = 0.0;
	verts[i * 3 + 0] = vertex;
			
	vertex = array_create(4);
	vertex[0] = x + lengthdir_x(beamAtkRanges[i], aimingDirection);
	vertex[1] = y + lengthdir_y(beamAtkRanges[i], aimingDirection);
	vertex[2] = c_white;
	vertex[3] = saturate(i + 0.2) * saturate(3.0 - i) * (0.3 + 0.1 * sin(Time.time * (1.7 + i * 0.5) + i)) * 0.5;
	verts[i * 3 + 1] = vertex;
			
	vertex = array_create(4);
	vertex[0] = x + lengthdir_x(beamAtkWidth, aimingDirection + 90) + lengthdir_x(beamAtkRanges[i], aimingDirection + beamAtkAngleOff);
	vertex[1] = y + lengthdir_y(beamAtkWidth, aimingDirection + 90) + lengthdir_y(beamAtkRanges[i], aimingDirection + beamAtkAngleOff);
	vertex[2] = c_white;
	vertex[3] = 0.0;
	verts[i * 3 + 2] = vertex;
}
for (var i = 0; i < 3; ++i)
{
	indices[i * 12 + 0] = (i + 0) * 3 + 0;
	indices[i * 12 + 1] = (i + 1) * 3 + 0;
	indices[i * 12 + 2] = (i + 0) * 3 + 1;
			
	indices[i * 12 + 3] = (i + 1) * 3 + 0;
	indices[i * 12 + 4] = (i + 1) * 3 + 1;
	indices[i * 12 + 5] = (i + 0) * 3 + 1;
			
	indices[i * 12 + 6] = (i + 0) * 3 + 2;
	indices[i * 12 + 7] = (i + 1) * 3 + 2;
	indices[i * 12 + 8] = (i + 0) * 3 + 1;
			
	indices[i * 12 + 9] = (i + 1) * 3 + 2;
	indices[i * 12 +10] = (i + 1) * 3 + 1;
	indices[i * 12 +11] = (i + 0) * 3 + 1;
}

m_meleeTelegraphVolume.m_vertices = verts;
m_meleeTelegraphVolume.m_indices = indices;