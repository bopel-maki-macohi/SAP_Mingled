package maki.sap_mingled.states.backend;

import flixel.FlxState;
import flixel.util.FlxTimer;

class SAPState extends FlxState
{
	var outroDelay:NullFloat;

	override function startOutro(onOutroComplete:() -> Void)
	{
		if (outroDelay == null || outroDelay == 0) onOutroComplete();
		else FlxTimer.wait(outroDelay, onOutroComplete);
	}
}
