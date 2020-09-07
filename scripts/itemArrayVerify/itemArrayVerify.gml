function itemArrayVerify(argument0) {
	var itemArray = argument0;
	var itemArrayLength = array_length_1d(itemArray);

	for (var i = 0; i < itemArrayLength; ++i)
	{
		for (var isub = 0; isub < itemArrayLength; ++isub)
		{
			if (i == isub)
				continue;
			
			if (itemArray[i] == itemArray[isub])
			{
				show_error("Invalid inventory entry. Duplicated entries.", false);	
			}
		}
	}


}
