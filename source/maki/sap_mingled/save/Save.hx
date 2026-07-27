package maki.sap_mingled.save;

import flixel.FlxG;
import flixel.math.FlxRandom;
import lime.app.Application;

class Save
{
	public static final SAVE_VERSION:NullInt = 13;

	public static var data(get, set):SaveData;

	static function get_data():SaveData return FlxG.save.data.sap;

	static function set_data(_data:SaveData):SaveData
	{
		if (!FlxG.save.isBound) return null;

		return FlxG.save.data.sap = _data;
	}

	public static var random:FlxRandom;

	public static function init()
	{
		random = new FlxRandom();

		FlxG.save.bind('SAP_Mingled', 'Maki');

		final raw_data:Dynamic = FlxG.save.data.sap;

		if (DefineMacro.defined('SAPM_SAVE_CLEAR')) clear();
		else load();

		Application.current.onExit.add(function(l)
		{
			save();
		});

		trace('Initalized Save Data:\n${raw_data}');
	}

	public static function clear()
	{
		data = null;

		load();
	}

	public static function load()
	{
		data ??= {
			save_version: null,
			seed: null,
		}

		data.save_version ??= Save.SAVE_VERSION;

		data.seed ??= random.currentSeed;
		random.currentSeed = data.seed;

		/**
		 * Check version shit here
		 */

		data.save_version = Save.SAVE_VERSION;

		cleanup();
	}

	public static function checkSaveRange(min:NullInt, max:NullInt, whenInRange:FuncVoid)
	{
		if (data == null) return;
		if (whenInRange == null) return;

		if (min == null && max == null) return;

		if (max == null)
		{
			if (data.save_version >= min) whenInRange();
			return;
		}

		if (min == null)
		{
			if (data.save_version < max) whenInRange();
			return;
		}

		if (data.save_version >= min && data.save_version < max) whenInRange();
	}

	public static function cleanup()
	{
		data = {
			save_version: Save.SAVE_VERSION,
			seed: random.currentSeed,
		}
	}

	public static function save()
	{
		cleanup();

		trace('Ending Save Data:\n${data}');
		FlxG.save.flush();
	}
}
