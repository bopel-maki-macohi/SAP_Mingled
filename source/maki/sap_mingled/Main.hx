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

	public static var debugText:DebugText;

	public static var stateCode:String = '';

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

		FlxG.mouse.visible = mouseVisible;
	}

	override function draw()
	{
		super.draw();
	}

	override function switchState()
	{
		final classPackage = Type.getClassName(Type.getClass(_nextState.createInstance() ?? _state ?? null));
		final className = classPackage.split('.')[classPackage.split('.').length - 1];

		stateCode = classPackage?.substr('maki.sap_mingled.states.'.length)?.toLowerCase();
		if (stateCode != null) stateCode = stateCode.substr(0, stateCode.length - className.length - 1);
		stateCode ??= 'unknownstate';

		FlxG.watch.addQuick('State Class Package', classPackage);
		FlxG.watch.addQuick('State Class Name', className);
		FlxG.watch.addQuick('State Locale Code', stateCode);

		super.switchState();
	}
}
