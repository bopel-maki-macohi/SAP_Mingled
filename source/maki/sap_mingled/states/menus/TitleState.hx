package maki.sap_mingled.states.menus;

import flixel.FlxState;
import flixel.addons.display.FlxBackdrop;
import flixel.text.FlxText;

class TitleState extends FlxState
{
	var protoBG:FlxBackdrop;
	var protoLogo:FlxText;

	override function create()
	{
		super.create();

		protoBG = new FlxBackdrop(get_path_game_menus('grid/${Save.data?.ui?.grid_skin ?? 'modern'}'));
		protoBG.setGraphicSize(32);
		add(protoBG);

		protoBG.velocity.set(16, 16);

		protoLogo = new FlxText(0, 0, 0, Constants.GAME_TITLE, 16);
		add(protoLogo);
		protoLogo.screenCenter();

		protoLogo.setBorderStyle(OUTLINE_CARDINAL, 0xFF000000, 2);
	}
}
