package maki.sap_mingled.assets.graphics;

import flixel.FlxSprite;
import flixel.util.FlxColor;

class SAPSprite extends FlxSprite
{
	public var gravity:Float = 0;

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		this.y += gravity;
	}

	override function makeGraphic(width:Int, height:Int, color:FlxColor = FlxColor.WHITE, unique:Bool = false,
			?key:String):SAPSprite return cast super.makeGraphic(width, height, color, unique, key);
}
