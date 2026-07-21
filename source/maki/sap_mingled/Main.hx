package maki.sap_mingled;

import flixel.FlxGame;
import openfl.events.Event;

class Main extends FlxGame
{
	public function new()
	{
		super(640, 480, StartingState.get(), 60, 60, true, false);
	}

	override function create(_:Event)
	{
		Save.init();

		super.create(_);
	}
}
