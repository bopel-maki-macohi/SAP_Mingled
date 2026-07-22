package maki.sap_mingled.states.backgrounds;

import flixel.FlxState;
import flixel.addons.display.FlxBackdrop;

class GridState extends FlxState
{
	var protoBG:FlxBackdrop;

	override function create()
	{
		super.create();

		protoBG = new FlxBackdrop(get_path_game_menus('grid/${Save.data?.ui?.grid_skin ?? 'modern'}'));
		protoBG.setGraphicSize(32);
		add(protoBG);

		protoBG.velocity.set(16, 16);
	}
}
