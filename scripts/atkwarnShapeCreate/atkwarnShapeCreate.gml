/// @function atkwarnShapeCreate(owner)
/// @param owner {Instance}
function atkwarnShapeCreate(argument0) {

	var owner = argument0;
	var shape = inew(ob_attackWarnShape);
		shape.m_source = owner;
		shape.depth = iexists(owner) ? (owner.depth - 10) : (depth - 10);
	
	return shape;


}
