package maki.sap_mingled.states.menus.options;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;

class ControlOptionSubState extends SAPSubState
{
	var control:String;

	public function new(control = '')
	{
		super();

		this.control = control;
	}

	var bg = new SAPSprite();

	var substateCam = new FlxCamera();

	override function create()
	{
		super.create();

		FlxG.cameras.add(substateCam, false);

		bg.makeGraphic(Math.round(FlxG.width * 1.1), Math.round(FlxG.height * 1.1), FlxColor.BLACK);
		bg.alpha = 0;
		add(bg);

		FlxTween.tween(bg, {alpha: 0.3}, 1, {
			ease: FlxEase.quintOut,
		});

		bg.cameras = [substateCam];
	}
}
