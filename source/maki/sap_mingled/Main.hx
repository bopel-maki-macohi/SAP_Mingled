package maki.sap_mingled;

import flixel.FlxG;
import flixel.FlxGame;
import openfl.events.Event;

class Main extends FlxGame
{
	public function new()
	{
		Save.init();

		super(640, 480, StartingState.get(), 60, 60, true, false);
	}

	public static var mouse_enabled:Bool = false;

	override function create(_:Event)
	{
		super.create(_);
	}

	override function step()
	{
		super.step();
	}

	override function update()
	{
		super.update();

		FlxG.mouse.visible = mouse_enabled;
	}

	override function draw()
	{
		super.draw();
	}
}
