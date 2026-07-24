package maki.sap_mingled.save;

import flixel.FlxG;
import flixel.math.FlxRandom;
import lime.app.Application;

class Save
{
	public static final SAVE_VERSION:NullInt = 9;

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
			seed: null,
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

		data.ui ??= {
			grid_skin: null,
			debug_display: null,
		};

		data.ui.grid_skin ??= OptionsUtil.grid_skins[0];
		data.ui.debug_display ??= #if debug true #else false #end;

		data.controls ??= {
			ui_up: null,
			ui_up_alt: null,
			ui_down: null,
			ui_down_alt: null,
			ui_left: null,
			ui_left_alt: null,
			ui_right: null,
			ui_right_alt: null,
			ui_accept: null,
			ui_accept_alt: null,
			ui_back: null,
			ui_back_alt: null,
		};

		data.controls.ui_up ??= 'UP';
		data.controls.ui_up_alt ??= 'W';

		data.controls.ui_down ??= 'DOWN';
		data.controls.ui_down_alt ??= 'S';

		data.controls.ui_left ??= 'LEFT';
		data.controls.ui_left_alt ??= 'A';

		data.controls.ui_right ??= 'RIGHT';
		data.controls.ui_right_alt ??= 'D';

		data.controls.ui_accept ??= 'ENTER';
		data.controls.ui_accept_alt ??= '';

		data.controls.ui_back ??= 'ESCAPE';
		data.controls.ui_back_alt ??= '';

		if (data.ui.grid_skin == 'minecraft' && OptionsUtil.grid_skins.contains('minceraft')) data.ui.grid_skin = 'minceraft';
		if (data.ui.grid_skin == 'minceraft' && OptionsUtil.grid_skins.contains('minecraft')) data.ui.grid_skin = 'minecraft';

		data.seed ??= random.currentSeed;
		random.currentSeed = data.seed;
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
			persistance_keys: data?.game?.persistance_keys ?? [],
			slots: data?.game?.slots ?? [],
		}

		data.ui = {
			grid_skin: data.ui.grid_skin,
			debug_display: data.ui.debug_display,
		};

		data.controls = {
			ui_up: data.controls.ui_up,
			ui_up_alt: data.controls.ui_up_alt,
			ui_down: data.controls.ui_down,
			ui_down_alt: data.controls.ui_down_alt,
			ui_left: data.controls.ui_left,
			ui_left_alt: data.controls.ui_left_alt,
			ui_right: data.controls.ui_right,
			ui_right_alt: data.controls.ui_right_alt,
			ui_accept: data.controls.ui_accept,
			ui_accept_alt: data.controls.ui_accept_alt,
			ui_back: data.controls.ui_back,
			ui_back_alt: data.controls.ui_back_alt,
		};

		data = {
			save_version: Save.SAVE_VERSION,
			game: data.game,
			ui: data.ui,
			controls: data.controls,
			seed: random.currentSeed,
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
