package maki.sap_mingled.game;

import flixel.FlxGame;

class SecondaryGame extends FlxGame
{
	public function new()
	{
		super(Main.gameMeta.dimensions[0], Main.gameMeta.dimensions[1], StartingState.getSecondary(), Main.gameMeta.framerate[0], Main.gameMeta.framerate[0],
			!Main.gameMeta.splash[0], false);
	}
}
