package maki.sap_mingled;

import openfl.display.Sprite;

class Main extends Sprite
{
	public static var gameMeta = ClassUtil.getMetadata(Constants.GAME_INFO);

	public static var primaryGame:PrimaryGame;
	public static var secondaryGame:SecondaryGame;

	override public function new()
	{
		super();

		addChild(secondaryGame = new SecondaryGame());
		addChild(primaryGame = new PrimaryGame());
	}
}
