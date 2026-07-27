package maki.sap_mingled.assets;

class AssetManager
{
	public static function get_path(path:String, ?ext:String):String return 'assets/$path${ext != null ? '.$ext' : ''}';

	public static function get_path_ost(path:String, ?ext:String = 'ogg'):String return get_path('ost/$path', ext);

}
