package maki.sap_mingled.game;

import flixel.FlxG;
import flixel.FlxGame;
import flixel.util.FlxColor;
import lime.app.Application;
import openfl.events.Event;

class MainGame extends FlxGame
{
	public function new()
	{
		Save.init();

		LanguageManager.init();

		super(Main.gameMeta.dimensions[0], Main.gameMeta.dimensions[1], StartingState.getPrimary(), Main.gameMeta.framerate[0], Main.gameMeta.framerate[0],
			!Main.gameMeta.splash[0], false);
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

		FlxG.camera.bgColor = FlxColor.TRANSPARENT;
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
