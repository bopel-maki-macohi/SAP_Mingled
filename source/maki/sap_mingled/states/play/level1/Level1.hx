package maki.sap_mingled.states.play.level1;

import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
import flixel.util.FlxColor;

/**
 * Port is running,
 * avoiding bombs and collecting spare ammo when he can.
 * 
 * The enemy flies above, spawning bombs.
 * 
 * The enemy is only damagable when you have ammo to shoot at them.
 */
class Level1 extends Level
{
	var bullets:FlxTypedSpriteGroup<FlxSprite>;
	var obstacles:FlxTypedSpriteGroup<FlxSprite>;
	var enemy:FlxSprite;
	var port:FlxSprite;

	override function create()
	{
		super.create();

		bullets = new FlxTypedSpriteGroup<FlxSprite>();
		obstacles = new FlxTypedSpriteGroup<FlxSprite>();
		enemy = new FlxSprite();
		port = new FlxSprite();

		port.makeGraphic(32, 32, FlxColor.MAGENTA);
		enemy.makeGraphic(64, 64, FlxColor.RED);

		add(bullets);
		add(obstacles);
		add(enemy);
		add(port);

		port.screenCenter();
		enemy.screenCenter();

		port.y += port.height * 4;
		enemy.y -= enemy.height * 2;
	}

	override function unpausedUpdate(elapsed:Float)
	{
		super.unpausedUpdate(elapsed);

		if (Save.random.bool(30))
		{
			trace('Ammo / Obstacle spawn chance');
		}
	}
}
