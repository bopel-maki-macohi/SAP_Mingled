package maki.sap_mingled.assets;

import haxe.Json;
import lime.utils.Assets;

class LanguageManager
{
	public static var locale:LangFile = null;

	public static function init()
	{
		loadLocale('eng-US');
	}

	public static function loadLocale(_locale:String)
	{
		try
		{
			locale = Json.parse(Assets.getText(get_path_data_lang(_locale)));
		}
		catch (e)
		{
			trace('Error loading locale "$_locale" : $e');
			trace('\tUsing eng-US...');
			locale = Json.parse(Assets.getText(get_path_data_lang('eng-US')));
		}
	}

	public static function localeKey(key:String):String
	{
		if (locale != null)
		{
			var field = Reflect.field(locale?.keys, key);

			if (field != null) return field;
		}

		return '[$key]';
	}
}
