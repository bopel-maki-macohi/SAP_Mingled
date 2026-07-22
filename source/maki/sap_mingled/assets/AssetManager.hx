package maki.sap_mingled.assets;

class AssetManager
{
	public static function get(path:String, ?ext:String):String return 'assets/$path${ext != null ? '.$ext' : ''}';

	public static function get_path_ost(path:String, ?ext:String = 'ogg'):String return get('ost/$path', ext);

	public static function get_path_game(path:String, ?ext:String = 'png'):String return get('game/$path', ext);

	public static function get_path_game_menus(path:String, ?ext:String = 'png'):String return get_path_game('menus/$path', ext);
	
	public static function get_path_game_cutscene(path:String, ?ext:String = 'png'):String return get_path_game('cutscene/$path', ext);
	
	public static function get_path_data(path:String, ?ext:String = 'json'):String return get('data/$path', ext);

	public static function get_path_data_lang(path:String, ?ext:String = 'json'):String return get_path_data('lang/$path', ext);
}
