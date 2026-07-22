package maki.sap_mingled.util;

import lime.app.Application;

class Constants
{
	public static var GAME_TITLE(get, never):String;

	static function get_GAME_TITLE():String return Application?.current?.meta?.get('name') ?? 'N / A';
}
