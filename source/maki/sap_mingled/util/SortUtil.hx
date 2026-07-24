package maki.sap_mingled.util;

class SortUtil
{
	// Yoinked from FNF
	public static function alphabetically(a:String, b:String):Int
	{
		a = a.toUpperCase();
		b = b.toUpperCase();

		// Sort alphabetically. Yes that's how this works.
		return a == b ? 0 : a > b ? 1 : -1;
	}
}
