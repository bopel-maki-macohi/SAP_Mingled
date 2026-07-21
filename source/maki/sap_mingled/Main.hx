package maki.sap_mingled;

import flixel.FlxGame;
import openfl.events.Event;

class Main extends FlxGame
{
	public function new()
	{
		Save.init();

		super(640, 480, StartingState.get(), 60, 60, true, false);
	}

	override function create(_:Event)
	{
		super.create(_);
	}
}
