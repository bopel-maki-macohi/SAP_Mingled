package maki.sap_mingled.save;

import flixel.FlxG;
import lime.app.Application;

class Save
{
	public static final SAVE_VERSION:NullInt = 3;

	public static var data(get, set):SaveData;

	static function get_data():SaveData return FlxG.save.data.sap;

	static function set_data(_data:SaveData):SaveData
	{
		if (!FlxG.save.isBound) return null;

		return FlxG.save.data.sap = _data;
	}

	public static function init()
	{
		FlxG.save.bind('SAP_Mingled', 'Maki');

		final raw_data = FlxG.save.data.sap;

		#if SAPM_SAVE_CLEAR
		clear();
		#else
		load();
		#end

		Application.current.onExit.add(function(l)
		{
			save();
		});

		if (raw_data == data)
		{
			trace('Loaded Save Data:\n${data}');
		}
		else
		{
			trace('Old Save Data:\n${raw_data}');
			trace('New Save Data:\n${data}');
		}
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
			game: null,
			ui: null,
			controls: null,
		}

		data.game ??= {
			persistance_keys: null,
			slots: null,
		}

		data.save_version ??= Save.SAVE_VERSION;

		/**
		 * Check version shit here
		 */

		data.save_version = Save.SAVE_VERSION;

		data.game ??= {
			persistance_keys: null,
			slots: null,
		}

		data.game.persistance_keys ??= [];
		data.game.slots ??= [];

		data.ui ??= {};

		data.controls ??= {};
	}

	public static function checkSaveRange(min:NullInt, max:NullInt, whenInRange:FuncVoid)
	{
		if (data == null) return;
		if (whenInRange == null) return;

		if (data.save_version >= min && data.save_version < max) whenInRange();
	}

	public static function save()
	{
		data.game = {
			persistance_keys: data.game.persistance_keys,
			slots: data.game.slots,
		}

		data.ui = {};

		data.controls = {};

		data = {
			save_version: Save.SAVE_VERSION,
			game: data.game,
			ui: data.ui,
			controls: data.controls,
		}

		trace('Ending Save Data:\n${data}');
		FlxG.save.flush();
	}

	public static function addGlobalPersistanceKey(key:String)
	{
		if (data?.game == null) return;

		if (!hasGlobalPersistanceKey(key)) data.game.persistance_keys.push(key);
	}

	public static function addLocalPersistanceKey(key:String, slot:Int = 0)
	{
		if (data?.game?.slots == null) return;

		if (data.game.slots[slot] == null) return;

		if (!hasLocalPersistanceKey(key, slot)) data.game.slots[slot].persistance_keys.push(key);
	}

	public static function hasGlobalPersistanceKey(key:String):Bool
	{
		return data?.game?.persistance_keys?.contains(key) ?? false;
	}

	public static function hasLocalPersistanceKey(key:String, slot:Int = 0):Bool
	{
		return data?.game?.slots[slot]?.persistance_keys?.contains(key) ?? false;
	}
}
