package maki.sap_mingled.states.play.level1;

import flixel.FlxG;
import flixel.util.FlxColor;

class Level1 extends Level
{
	var ground:SAPSprite;

	/**
	 * implement `portRestY` with some gravity bounds thing in `SAPSPrite`,
	 * 
	 * only allowing gravity to apply in a certain region
	 */
	var port:SAPSprite;

	var enemy:SAPSprite;

	override function create()
	{
		super.create();

		ground = new SAPSprite().makeGraphic(Math.round(FlxG.width * 1.1), 120);
		port = new SAPSprite().makeGraphic(32, 32, FlxColor.MAGENTA);
		enemy = new SAPSprite().makeGraphic(64, 64, FlxColor.RED);

		ground.screenCenter();
		ground.y = FlxG.height - ground.height;

		port.screenCenter();
		enemy.screenCenter();

		enemy.y -= enemy.height * 2;
		port.y = ground.y - port.height;

		enemy.health = 10;
		port.health = 5;

		add(ground);
		add(port);
		add(enemy);
	}
}
