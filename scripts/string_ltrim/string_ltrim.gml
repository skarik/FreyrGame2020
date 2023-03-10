/// @description  string_ltrim(str)
/// @param str
function string_ltrim(argument0) {
	//
	//  Returns the given string with whitespace stripped from its start.
	//  Whitespace is defined as SPACE, TAB, NL, VT, FF, CR.
	//
	//      str         string of text, string
	//
	/// GMLscripts.com/license
	{
	    var str,l,r,o;
	    str = argument0;
	    l = 1;
	    r = string_length(str);
	    repeat (r) {
	        o = ord(string_char_at(str,l));
	        if ((o > 8) && (o < 14) || (o == 32)) l += 1;
	        else break;
	    }
	    return string_copy(str,l,r-l+1);
	}




}
