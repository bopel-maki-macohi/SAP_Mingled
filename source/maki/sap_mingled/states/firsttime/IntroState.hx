package maki.sap_mingled.states.firsttime;

import flixel.FlxState;

class IntroState extends FlxState
{
	override function create()
	{
		super.create();

		SAPAudioManager.playMusic({
			path: get_path_ost('BigBang'),
		});
	}
}
