package maki.sap_mingled.util;

import flixel.FlxG;
import flixel.math.FlxMath;

class OptionsUtil
{
	public static var grid_skins:Array<String> = OptionMacro.buildArray('grid_skins');

	public static function option_text(key_base:String, value:Any):String
	{
		return '${getLanguageKey(key_base)} : ${getLanguageKey('$key_base.${value}', value)}';
	}

	public static function array_option<T>(current:T, values:Array<T>):T
	{
		if (values == null) return current;

		var i = values.indexOf(current) + ((FlxG.keys.pressed.SHIFT) ? -1 : 1);

		if (i > values.length - 1) i = 0;
		if (i < 0) i = values.length - 1;

		return values[i];
	}

	public static function bool_option(current:Bool):Bool return !current;

	public static function float_option(current:Float, params:FloatOptionParams):Float
	{
		if (params == null) return current;

		current += params.increment * ((FlxG.keys.pressed.SHIFT) ? -1 : 1);

		if (current >= params.max) current = params?.min ?? 0;

		return FlxMath.roundDecimal(current, params?.decimals ?? 2);
	}

	public static function int_option(current:Int, params:IntOptionParams):Int
	{
		if (params == null) return current;

		current += params.increment * ((FlxG.keys.pressed.SHIFT) ? -1 : 1);

		if (current >= params.max) current = params?.min ?? 0;

		return current;
	}
}
