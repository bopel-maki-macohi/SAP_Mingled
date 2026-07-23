package maki.sap_mingled.states.play.level1;

import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;

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

		add(bullets);
		add(obstacles);
		add(enemy);
		add(port);
	}
}
