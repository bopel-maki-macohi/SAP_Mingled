package maki.sap_mingled.states.backend;

import flixel.FlxState;
import flixel.util.FlxTimer;

class SAPState extends FlxState
{
	override public function new()
	{
		super();

		Main.onGameResized.add(onGameResized);
	}

	function onGameResized(width:Int, height:Int) {}

	var outroDelay:NullFloat;

	override function startOutro(onOutroComplete:() -> Void)
	{
		if (outroDelay == null || outroDelay == 0) onOutroComplete();
		else FlxTimer.wait(outroDelay, onOutroComplete);
	}
}
