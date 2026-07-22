package maki.sap_mingled.states.menus.options;

import flixel.FlxG;
import flixel.FlxState;

@localePrefix('menus.options')
class OptionsMenuState extends FlxState
{
	override function create()
	{
		super.create();

		add(new GridBG());
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (Controls.justPressed('ui_back')) FlxG.switchState(() -> new TitleState());
	}
}
