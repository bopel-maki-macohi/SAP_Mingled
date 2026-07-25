package maki.sap_mingled.assets;

import haxe.Json;
import lime.utils.Assets;

class LanguageManager
{
	public static var locale:LangFile = null;

	@:allow(maki.sap_mingled.Main)
	static function init()
	{
		loadLocale('eng-US');
	}

	@:allow(maki.sap_mingled.Main)
	static function loadLocale(_locale:String)
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

	public static function getClassLanguageKey(params:ClassLanguageKeyParams):String
	{
		var classLocalePrefix = getClassLocalePrefix(params.cls);

		params.key = '${classLocalePrefix}${params.key}';
		return getLanguageKey(params);
	}

	public static function getLanguageKey(params:LanguageKeyParams):String
	{
		if (locale != null && params.key != null)
		{
			final _key = '${params.key}'.replace(' ', '_');

			var field = Reflect.field(locale?.keys, _key);
			if (field != null)
			{
				for (i => token in params.tokens) {}

				return field;
			}
		}

		if (params.defaultMsg == null && params.key == null) return '[???]';
		else if (params.defaultMsg != null && params.key == null) return params.defaultMsg;
		else return params.key;
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
