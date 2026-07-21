package maki.sap_mingled.save;

import flixel.FlxG;
import lime.app.Application;

class Save
{
	public static final SAVE_VERSION:NullInt = 1;

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

		trace('Save Data:\n\t${data}');
	}

	public static function load()
	{
		data ??= {
			save_version: null,
		};

		data.save_version ??= Save.SAVE_VERSION;
	}

	public static function checkSaveRange(min:NullInt, max:NullInt, whenInRange:FuncVoid)
	{
		if (data == null) return;
		if (whenInRange == null) return;

		if (data.save_version >= min && data.save_version < max) whenInRange();
	}

	public static function save()
	{
		data = {
			save_version: Save.SAVE_VERSION,
		};
	}
}
