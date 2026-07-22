package maki.sap_mingled;

import flixel.FlxG;
import flixel.FlxGame;
import openfl.events.Event;

class Main extends FlxGame
{
	public function new()
	{
		Save.init();

		LanguageManager.init();

		super(640, 480, StartingState.get(), 60, 60, true, false);
	}

	public static var mouseVisible:Bool = false;

	public static var debugDisplay:DebugDisplay;

	override function create(_:Event)
	{
		super.create(_);

		debugDisplay = new DebugDisplay(4, 4, 0xFFFFFFFF);
		addChild(debugDisplay);

		// trace(LanguageManager.getClassLocalePrefix(this, false));
		// trace(LanguageManager.getClassLocalePrefix(DebugDisplay, false));
	}

	override function step()
	{
		super.step();
	}

	override function update()
	{
		super.update();

		FlxG.mouse.visible = mouseVisible;
	}

	override function draw()
	{
		super.draw();
	}
}
