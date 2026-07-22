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

	public static var mouseEnabled:Bool = false;

	public static var debugText:DebugText;

	override function create(_:Event)
	{
		super.create(_);

		debugText = new DebugText(2, 2, 0xFFFFFFFF);
		addChild(debugText);
	}

	override function step()
	{
		super.step();
	}

	override function update()
	{
		super.update();

		FlxG.mouse.visible = mouseEnabled;
	}

	override function draw()
	{
		super.draw();
	}
}
