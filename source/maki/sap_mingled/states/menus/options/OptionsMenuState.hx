package maki.sap_mingled.states.menus.options;

import flixel.FlxState;

@localePrefix('menus.options')
class OptionsMenuState extends FlxState
{
	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (Controls.justPressed('ui_back')) FlxG.switchState(() -> new TitleState());
	}
}
