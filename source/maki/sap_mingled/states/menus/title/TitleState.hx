package maki.sap_mingled.states.menus.title;

import flixel.FlxState;
import flixel.addons.display.FlxBackdrop;
import flixel.text.FlxText;

class TitleState extends FlxState
{
	var protoBG:FlxBackdrop;
	var protoLogo:FlxText;

	var playButton:TitleButton;

	var selection:Int = 0;

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

		protoLogo.y -= protoLogo.height * 2;

		playButton = new TitleButton('Play', 0);
		add(playButton);
		playButton.screenCenter();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		playButton.updateSelection(selection);
	}
}
