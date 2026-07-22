package maki.sap_mingled;

import flixel.FlxG;
import flixel.FlxGame;
import lime.app.Application;
import openfl.events.Event;

class Main extends FlxGame
{
	public function new()
	{
		Save.init();

		LanguageManager.init();

		var gameMeta = ClassUtil.getMetadata(Constants.GAME_INFO);
		super(gameMeta.dimensions[0], gameMeta.dimensions[1], StartingState.get(), gameMeta.framerate[0], gameMeta.framerate[0], !gameMeta.splash[0], false);
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

		Application.current.window.title = Constants.GAME_TITLE;
	}

	override function step()
	{
		super.step();

		debugDisplay.visible = !FlxG.debugger.visible;
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
