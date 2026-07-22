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

	var order = [
		'unknown',
		'unknown',
		'unknown',
		'unknown',
		'unknown',
		'unknown',
		'unknown',
		'unknown',
		'unknown',
		'unknown',
	];

	var selection = 0;

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

		icons.cameras = [iconsCam];
		add(icons);

		for (i => entry in order)
		{
			var icon = new LevelIcon(entry, i);
			icons.add(icon);
		}
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (Controls.justPressed('ui_back')) FlxG.switchState(() -> new TitleState());

		for (icon in icons)
		{
			icon.x = (icon.ID * icon.width);

			icon.color = FlxColor.WHITE;
			if (selection == icon.ID)
			{
				iconsCamFollow.x = icon.x;
				icon.color = FlxColor.YELLOW;
			}
		}

		if (Controls.justPressed('ui_left')) changeSelection(-1);
		if (Controls.justPressed('ui_right')) changeSelection(1);
	}

	function changeSelection(amount:Int)
	{
		selection += amount;

		if (selection < 0) selection = icons.length - 1;
		if (selection > icons.length - 1) selection = 0;
	}
}
