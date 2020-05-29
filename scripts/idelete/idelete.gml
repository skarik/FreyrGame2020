/// @function idelete(object_to_delete)
if (argument0 == noone)
	return 0;
with (argument0)
{
    instance_destroy();
}  
return 0;