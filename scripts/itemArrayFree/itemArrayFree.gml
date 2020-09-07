function itemArrayFree(argument0) {
	var itemArray = argument0;
	var itemArrayLength = array_length_1d(itemArray);

	for (var i = 0; i < itemArrayLength; ++i)
	{
		itemEntryFree(itemArray[i]);
	}


}
