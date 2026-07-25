package maki.sap_mingled.assets.graphics;

import flixel.FlxSprite;

class SAPSprite extends FlxSprite
{
	public var gravity:Float = 0;

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		this.y += gravity;
	}
}
