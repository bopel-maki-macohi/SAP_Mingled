package maki.sap_mingled.util;

import flixel.FlxG;
import flixel.input.keyboard.FlxKey;

class Controls
{
	public static function withControls(control:String, method:FuncAInBoolOut<Array<NullFlxKey>>):Bool
	{
		if (method == null)
		{
			trace('You can\'t do anything with "$control" cause method is null');
			return false;
		}

		var saveField = Reflect.field(Save.data.controls, '$control');
		var saveFieldAlt = Reflect.field(Save.data.controls, '${control}_alt');

		if (saveField == null && saveFieldAlt == null)
		{
			trace('Cannot check if "$control" is pressed : Invalid Control');
			return false;
		}

		var mainKey:NullFlxKey = null;
		var altKey:NullFlxKey = null;
		
		mainKey = FlxKey.fromString(saveField);
		altKey = FlxKey.fromString(saveFieldAlt);

		switch ([mainKey, altKey])
		{
			case [null, _]: return method([altKey]);
			case [NONE, _]: return method([altKey]);
			case [_, null]: return method([mainKey]);
			case [_, NONE]: return method([mainKey]);
			case [_, _]: return method([mainKey, altKey]);
		}

		return false;
	}

	public static function pressed(control:String):Bool
	{
		return withControls(control, function(keys):Bool
		{
			return FlxG.keys.anyPressed(keys);
		});
	}

	public static function justPressed(control:String):Bool
	{
		return withControls(control, function(keys):Bool
		{
			return FlxG.keys.anyJustPressed(keys);
		});
	}

	public static function justReleased(control:String):Bool
	{
		return withControls(control, function(keys):Bool
		{
			return FlxG.keys.anyJustReleased(keys);
		});
	}
}
