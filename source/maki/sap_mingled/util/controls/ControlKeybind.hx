package maki.sap_mingled.util.controls;

import flixel.FlxG;
import flixel.input.keyboard.FlxKey;

class ControlKeybind
{
	public var keys(default, null):Array<FlxKey> = [];

	public function new(keys:Array<FlxKey>)
	{
		this.keys = keys;
	}

	public var pressed(get, null):Bool;

	function get_pressed():Bool return FlxG.keys.anyPressed(keys);

	public var justPressed(get, null):Bool;

	function get_justPressed():Bool return FlxG.keys.anyJustPressed(keys);

	public var justReleased(get, null):Bool;

	function get_justReleased():Bool return FlxG.keys.anyJustReleased(keys);
}
