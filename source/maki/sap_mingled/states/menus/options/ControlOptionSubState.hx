package maki.sap_mingled.states.menus.options;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;

class ControlOptionSubState extends SAPSubState
{
	var bg = new FlxSprite();

	override function create()
	{
		super.create();

		bg.makeGraphic(Math.round(FlxG.width * 1.1), Math.round(FlxG.height * 1.1), FlxColor.BLACK);
		bg.alpha = 0;
		add(bg);

		FlxTween.tween(bg, {alpha: 0.3}, 1, {
			ease: FlxEase.quintOut,
		});
	}
}
