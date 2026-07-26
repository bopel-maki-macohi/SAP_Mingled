package maki.sap_mingled;

import flixel.FlxG;
import flixel.FlxGame;
import flixel.math.FlxPoint;
import flixel.util.FlxSignal.FlxTypedSignal;
import lime.app.Application;
import lime.utils.Log;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
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

	public static var borders:Bitmap;
	static var bordersOGDimensions:FlxPoint;

	override function create(_:Event)
	{
		Log.level = NONE;
		onGameResized = new FlxTypedSignal<Int->Int->Void>();
		Application.current.window.title = Constants.GAME_TITLE;

		debugDisplay = new DebugDisplay(4, 4, 0xFFFFFFFF);
		borders = new Bitmap(BitmapData.fromFile(get_path_game('borders')),);
		bordersOGDimensions = FlxPoint.weak(borders.width, borders.height);

		super.create(_);

		FlxG.stage?.addChild(debugDisplay);
		FlxG.stage?.addChildAt(borders, 0);
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

		borders.scaleY = borders.scaleX = width / bordersOGDimensions.x;
		// borders.scaleX = borders.scaleY = height / bordersOGDimensions.y;

		borders.x = (width - borders.width) / 2;
		borders.y = (height - borders.height) / 2;

		onGameResized.dispatch(width, height);
	}
}
