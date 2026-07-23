package maki.sap_mingled;

import flixel.FlxG;
import flixel.FlxGame;
import lime.app.Application;
import lime.utils.Log;
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
		Log.level = NONE;

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
	}

	override function update()
	{
		super.update();

		if (FlxG.keys.justPressed.F6 && FlxG.save.isBound) Save.data.ui.debug_display = !Save.data.ui.debug_display;
		if (FlxG.keys.justPressed.F7) mouseVisible = !mouseVisible;

		FlxG.mouse.visible = mouseVisible;
	}

	override function draw()
	{
		super.draw();
	}
}
