package maki.sap_mingled.util;

import lime.app.Application;

class Constants
{
	public static final GAME_INFO:GameInfo = new GameInfo();

	public static var GAME_TITLE(get, never):String;

	static function get_GAME_TITLE():String
	{
		return getLanguageKey('misc.title') ?? Application?.current?.meta?.get('name') ?? 'N / A';
	}

	/**
	 * IDEA:
	 * 
	 * Version comes from `Main` via the metadata shit.
	 * 
	 * What to have the version format though...
	 */
	public static var GAME_VERSION(get, never):String;

	static function get_GAME_VERSION():String return Application?.current?.meta?.get('version') ?? 'N / A';
}
