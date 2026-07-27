package maki.sap_mingled.util;

import flixel.util.typeLimit.NextState.InitialState;

class StartingState
{
	public static function get():InitialState
	{
		if (DefineMacro.defined('debug')) return LevelSelect;

		return null;
	}
}
