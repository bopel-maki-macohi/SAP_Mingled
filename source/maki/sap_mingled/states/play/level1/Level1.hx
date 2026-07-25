package maki.sap_mingled.states.play.level1;

import flixel.FlxG;
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
	var ground:SAPSprite;
	var bullets:FlxTypedSpriteGroup<SAPSprite>;
	var obstacles:FlxTypedSpriteGroup<SAPSprite>;
	var enemy:SAPSprite;

	var port:SAPSprite;
	var portRestY:Float = 0;

	override function create()
	{
		super.create();

		ground = new SAPSprite();
		bullets = new FlxTypedSpriteGroup<SAPSprite>();
		obstacles = new FlxTypedSpriteGroup<SAPSprite>();
		enemy = new SAPSprite();
		port = new SAPSprite();

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

		port.gravity += 0.8;

		FlxG.watch.addQuick('unpausedTick % 25', unpausedTick % 25);

		if (unpausedTick != 0 && unpausedTick % 25 == 0 && Save.random.bool(30))
		{
			spawnObstacle(Save.random.bool((1 / 10) * 100));
		}

		if (Controls.justPressed('game_jump') && port.y == portRestY)
		{
			port.gravity = -25;
		}

		port.gravity = Math.min(Math.max(port.gravity, -8), 8);
		port.y += port.gravity;

		if (port.y >= portRestY)
		{
			port.y = portRestY;
			port.gravity = 0;
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

			if (obstacle.overlaps(port))
			{
				// trace('Touch');
				obstacles.remove(obstacle);
				obstacle.destroy();
				continue;
			}
		}
	}

	function spawnObstacle(ammo = false)
	{
		// trace('Spawning ${(ammo) ? 'Ammo' : 'Bomb'}');

		var obstacle = new SAPSprite().makeGraphic(32, 32, (ammo) ? FlxColor.YELLOW : FlxColor.GRAY);
		obstacle.setPosition(FlxG.width + (obstacle.width * 2), portRestY);

		if (Save.random.bool())
		{
			obstacle.y -= obstacle.height * 3;
		}

		obstacles.add(obstacle);
	}
}
