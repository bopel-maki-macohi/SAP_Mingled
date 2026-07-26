package maki.sap_mingled;

import flixel.FlxG;
import flixel.FlxGame;
import flixel.system.scaleModes.*;
import flixel.util.FlxSignal.FlxTypedSignal;
import lime.app.Application;
import lime.utils.Log;
import openfl.events.Event;

class Main extends FlxGame
{
	public static final gameMeta = ClassUtil.getMetadata(Constants.GAME_INFO);

	public function new()
	{
		Save.init();

		LanguageManager.init();

		super(gameMeta.dimensions[0], gameMeta.dimensions[1], StartingState.get(), gameMeta.framerate[0], gameMeta.framerate[0], !gameMeta.splash[0], false);
	}

	public static var mouseVisible:Bool = false;

	public static var debugDisplay:DebugDisplay;

	override function create(_:Event)
	{
		Log.level = NONE;
		onGameResized = new FlxTypedSignal<Int->Int->Void>();
		Application.current.window.title = Constants.GAME_TITLE;

		debugDisplay = new DebugDisplay(4, 4, 0xFFFFFFFF);

		super.create(_);

		// FlxG.scaleMode = new FixedScaleMode();

		FlxG.stage?.addChild(debugDisplay);
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

	public static var onGameResized:FlxTypedSignal<Int->Int->Void>;

	override function resizeGame(width:Int, height:Int)
	{
		super.resizeGame(width, height);

		onGameResized.dispatch(width, height);
	}
}
