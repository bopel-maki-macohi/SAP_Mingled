package maki.sap_mingled.states.menus.play;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxState;
import flixel.group.FlxSpriteContainer.FlxTypedSpriteContainer;
import flixel.util.FlxColor;

@localePrefix('menus.play')
class PlayMenuState extends FlxState
{
	var icons:FlxTypedSpriteContainer<LevelIcon>;
	var iconsCam:FlxCamera;
	var iconsCamFollow:FlxObject;

	override function create()
	{
		super.create();

		icons = new FlxTypedSpriteContainer<LevelIcon>();
		iconsCam = new FlxCamera();
		iconsCamFollow = new FlxObject();

		FlxG.cameras.add(iconsCam, false);
		iconsCam.bgColor = FlxColor.TRANSPARENT;

		add(iconsCamFollow);

		iconsCam.follow(iconsCamFollow, LOCKON, 0.04);
		iconsCam.focusOn(iconsCamFollow.getPosition());
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (Controls.justPressed('ui_back')) FlxG.switchState(() -> new TitleState());
	}
}
