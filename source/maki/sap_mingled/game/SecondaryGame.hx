package maki.sap_mingled.game;

import flixel.FlxG;
import flixel.FlxGame;
import flixel.util.typeLimit.NextState;

class SecondaryGame extends FlxGame
{
	public function new()
	{
		super(Main.gameMeta.dimensions[0], Main.gameMeta.dimensions[1], StartingState.getSecondary(), Main.gameMeta.framerate[0], Main.gameMeta.framerate[0],
			!Main.gameMeta.splash[0], false);
	}

	public function changeState(nextState:NextState)
	{
		final stateOnCall = this._state;
		this._state.startOutro(function()
		{
			if (FlxG.state == stateOnCall) this._nextState = nextState;
			else FlxG.log.warn("`onOutroComplete` was called after the state was switched. This will be ignored");
		});
	}
}
