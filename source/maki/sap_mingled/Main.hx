package maki.sap_mingled;

import openfl.display.Sprite;

class Main extends Sprite
{
	public static var gameMeta = ClassUtil.getMetadata(Constants.GAME_INFO);

	override public function new()
	{
		super();

		addChild(new MainGame());
	}
}
