/// @function inew(object_index)
if (!iexists(argument0))
{
	return instance_create_depth(0, 0, 0, argument0);
}
return null;