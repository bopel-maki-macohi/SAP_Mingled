package maki.sap_mingled.save;

import flixel.FlxG;
import lime.app.Application;

class Save
{
	public static final SAVE_VERSION:NullInt = 2;

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

		load();

		Application.current.onExit.add(function(l)
		{
			save();
		});

		trace('Save Data:\n${data}');
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
		}

		data.game ??= {
			persistance_keys: null,
			slots: null,
		};

		data.save_version ??= Save.SAVE_VERSION;

		/**
		 * Check version shit here
		 */

		data.save_version = Save.SAVE_VERSION;

		data.game.persistance_keys ??= [];
		data.game.slots ??= [];
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
		};

		data.ui = {};

		data = {
			save_version: Save.SAVE_VERSION,
			game: data.game,
			ui: data.ui,
		};

		FlxG.save.flush();
	}
}
