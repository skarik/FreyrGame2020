var doodad = argument0;
var c_x1 = argument1;
var c_y1 = argument2;
var c_x2 = argument3;
var c_y2 = argument4;

if (m_health <= 0.0)
{
	doodadDestraOnDestroy();
	delete(this);
}