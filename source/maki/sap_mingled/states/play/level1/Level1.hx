package maki.sap_mingled.states.play.level1;

import flixel.FlxG;
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
	var ground:FlxSprite;
	var bullets:FlxTypedSpriteGroup<FlxSprite>;
	var obstacles:FlxTypedSpriteGroup<FlxSprite>;
	var enemy:FlxSprite;

	var port:FlxSprite;
	var portGravity:Float = 0;
	var portRestY:Float = 0;

	override function create()
	{
		super.create();

		ground = new FlxSprite();
		bullets = new FlxTypedSpriteGroup<FlxSprite>();
		obstacles = new FlxTypedSpriteGroup<FlxSprite>();
		enemy = new FlxSprite();
		port = new FlxSprite();

		ground.makeGraphic(Math.floor(FlxG.width * 1.1), Math.floor(FlxG.height / 4), FlxColor.WHITE);
		enemy.makeGraphic(64, 64, FlxColor.RED);
		port.makeGraphic(32, 32, FlxColor.MAGENTA);

		add(ground);
		add(bullets);
		add(obstacles);
		add(enemy);
		add(port);

		ground.screenCenter();
		ground.y = FlxG.height - ground.height;

		port.screenCenter();
		enemy.screenCenter();

		enemy.y -= enemy.height * 2;
		port.y = portRestY = ground.y - port.height;
	}

	override function unpausedUpdate(elapsed:Float)
	{
		super.unpausedUpdate(elapsed);

		portGravity += 1;
		portGravity = Math.min(Math.max(portGravity, -10), 10);

		FlxG.watch.addQuick('unpausedTick % 25', unpausedTick % 25);

		if (unpausedTick != 0 && unpausedTick % 25 == 0)
		{
			if (Save.random.bool(30)) spawnObstacle(Save.random.bool((1 / 10) * 100));
		}

		if (Controls.justPressed('game_jump') && port.y == portRestY)
		{
			portGravity = -25;
		}

		port.y += portGravity;

		if (port.y >= portRestY)
		{
			port.y = portRestY;
			portGravity = 0;
		}

		for (obstacle in obstacles)
		{
			obstacle.active = obstacle.x < FlxG.width + obstacle.width;
			obstacle.x -= obstacle.width * 0.25;

			if (obstacle.x < -obstacle.width)
			{
				obstacles.remove(obstacle);
				obstacle.destroy();
				continue;
			}
		}
	}

	function spawnObstacle(ammo = false)
	{
		trace('Spawning ${(ammo) ? 'Ammo' : 'Bomb'}');

		var obstacle = new FlxSprite().makeGraphic(32, 32, (ammo) ? FlxColor.YELLOW : FlxColor.GRAY);
		obstacle.setPosition(FlxG.width + (obstacle.width * 2), portRestY);

		if (Save.random.bool())
		{
			obstacle.y -= obstacle.height * 3;
		}

		obstacles.add(obstacle);
	}
}
