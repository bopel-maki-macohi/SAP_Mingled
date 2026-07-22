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

	public static function getLanguageKey(key:String, ?defaultStr:String):String
	{
		if (locale != null)
		{
			var field = Reflect.field(locale?.keys, key);

			if (field != null) return field;
		}

		return defaultStr ?? '[$key]';
	}

	public static function getClassLocalePrefix(_cls:Any):String
	{
		final cls = Type.getClass(_cls ?? null);

		final meta_localePrefix:Array<Dynamic> = ClassUtil.getMetadata(_cls)?.localePrefix;

		if (meta_localePrefix != null && meta_localePrefix?.length > 0)
		{
			var cur = null;

			for (prefix in meta_localePrefix)
			{
				if (prefix == null) continue;

				cur = '$prefix'.toLowerCase();
			}

			if (cur != null) return cur;
		}

		return Type.getClassName(cls)?.toLowerCase() ?? 'class';
	}
}
