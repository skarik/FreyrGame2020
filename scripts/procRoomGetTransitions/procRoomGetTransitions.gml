//@function procRoomGetTransitions(room_to_load)
//@param room_to_load

var transitions = [];
//var objects = argument1;
var room_bb = procRoomGetBBox(argument0);
var room_center = abbox_center(room_bb);

layer_set_target_room(argument0);

var all_layers = layer_get_all();
var layer_count = array_length_1d(all_layers);
for (var i = 0; i < layer_count; ++i)
{
	var currentLayer = all_layers[i];
	var elements = layer_get_all_elements(currentLayer);
	for (var iElement = 0; iElement < array_length_1d(elements); ++iElement)
	{
		var element = elements[iElement];
		var elementType = layer_get_element_type(element);
		//if (elementType == layerelementtype_instance)
		if (elementType == layerelementtype_sprite)
		{
			//var instance = layer_instance_get_instance(element);
			var sprite = layer_sprite_get_sprite(element);
			//if (instance.object_index == ob_transitionArea)
			if (sprite == sc_32x32c_blond)
			{
				var sprite_x = layer_sprite_get_x(element);
				var sprite_y = layer_sprite_get_y(element);
				
				if (sprite_x < 16)
				{
					//if (!array_contains(transitions, kCDirectionLeft))
					{
						transitions[array_length_1d(transitions)] = kCDirectionLeft;
					}
				}
				else if (sprite_x > abbox_right(room_bb) - 16)
				{
					//if (!array_contains(transitions, kCDirectionRight))
					{
						transitions[array_length_1d(transitions)] = kCDirectionRight;
					}
				}
				else if (sprite_y < 16)
				{
					//if (!array_contains(transitions, kCDirectionUp))
					{
						transitions[array_length_1d(transitions)] = kCDirectionUp;
					}
				}
				else if (sprite_y > abbox_bottom(room_bb) - 16)
				{
					//if (!array_contains(transitions, kCDirectionDown))
					{
						transitions[array_length_1d(transitions)] = kCDirectionDown;
					}
				}
			}
		}
	}
}
layer_reset_target_room();

return transitions;