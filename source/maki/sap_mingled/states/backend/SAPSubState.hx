package maki.sap_mingled.states.backend;

import flixel.FlxSubState;
import flixel.util.FlxTimer;

class SAPSubState extends FlxSubState
{
	var outroDelay:NullFloat;

	override function startOutro(onOutroComplete:() -> Void)
	{
		if (outroDelay == null || outroDelay == 0) onOutroComplete();
		else FlxTimer.wait(outroDelay, onOutroComplete);
	}
}
