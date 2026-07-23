package maki.sap_mingled.states.play;

class Level extends SAPState
{
	public var paused(default, null):Bool = false;

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (paused) pausedUpdate(elapsed);
		else unpausedUpdate(elapsed);
	}

	function pausedUpdate(elapsed:Float) {}

	function unpausedUpdate(elapsed:Float) {}
}
