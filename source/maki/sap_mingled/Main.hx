package maki.sap_mingled;

import flixel.FlxGame;

class Main extends FlxGame
{
	public function new()
	{
		super(640, 480, StartingState.get(), 60, 60, true, false);
	}
}
