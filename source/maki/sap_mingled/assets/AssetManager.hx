package maki.sap_mingled.assets;

class AssetManager
{
	public static function get(path:String, ?ext:String):String return 'assets/$path${ext != null ? '.$ext' : ''}';

	public static function get_file_ogg(path:String):String return get(path, 'ogg');

	public static function get_path_ost(path:String):String return get('ost/$path');
}
