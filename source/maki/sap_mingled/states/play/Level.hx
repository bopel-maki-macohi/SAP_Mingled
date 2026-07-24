package maki.sap_mingled.states.play;

import flixel.FlxG;

class Level extends SAPState
{
	public var paused(default, null):Bool = false;

	public var pausedTick:Int = 0;
	public var unpausedTick:Int = 0;

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		FlxG.watch.addQuick('pausedTick', pausedTick);
		FlxG.watch.addQuick('unpausedTick', unpausedTick);

		if (paused) pausedUpdate(elapsed);
		else unpausedUpdate(elapsed);
	}

	function pausedUpdate(elapsed:Float)
	{
		pausedTick++;
	}

	function unpausedUpdate(elapsed:Float)
	{
		unpausedTick++;
	}
}
