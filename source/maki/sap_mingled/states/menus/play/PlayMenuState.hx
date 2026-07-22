package maki.sap_mingled.states.menus.play;

import flixel.FlxG;
import flixel.FlxState;

@localePrefix('menus.play')
class PlayMenuState extends FlxState
{
	var testIcon:LevelIcon;

	override function create()
	{
		super.create();

		testIcon = new LevelIcon();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (Controls.justPressed('ui_back')) FlxG.switchState(() -> new TitleState());
	}
}
