package maki.sap_mingled.states.menus;

import flixel.FlxState;
import flixel.text.FlxText;

class TitleState extends FlxState
{
	var protoLogo:FlxText;

	override function create()
	{
		super.create();

		protoLogo = new FlxText(0, 0, 0, Constants.GAME_TITLE, 16);
		add(protoLogo);
		protoLogo.screenCenter();
	}
}
