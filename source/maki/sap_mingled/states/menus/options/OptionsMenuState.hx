package maki.sap_mingled.states.menus.options;

import flixel.FlxG;

@localePrefix('menus.options')
class OptionsMenuState extends SAPState
{
	override function create()
	{
		super.create();

		add(new GridBG());
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (Controls.justPressed('ui_back'))
		{
			outroDelay = SAPAudioManager.playSound({
				path: get_path_game_sounds('cancel')
			})?.length / 2000 ?? 0;
			FlxG.switchState(() -> new TitleState());
		}
	}
}
