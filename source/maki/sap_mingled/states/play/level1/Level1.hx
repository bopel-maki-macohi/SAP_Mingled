package maki.sap_mingled.states.play.level1;

import flixel.ui.FlxBar;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
import flixel.FlxG;
import flixel.util.FlxColor;

class Level1 extends Level
{
	var ground:SAPSprite;

	var port:SAPSprite;
	var portBar:FlxBar;

	var enemy:SAPSprite;
	var enemyBar:FlxBar;

	var bombs:FlxTypedSpriteGroup<SAPSprite>;
	var ammo:FlxTypedSpriteGroup<SAPSprite>;

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

		port.enableGravity()
			.setGravityMinMax(-12, 12)
			.setGravityConstant(0.8)
			.setGravityRegion(0, 0, FlxG.width, ground.y - port.height)
			.enableForcedGravityRegion();

		enemy.health = 10;
		port.health = 5;

		bombs = new FlxTypedSpriteGroup<SAPSprite>();
		ammo = new FlxTypedSpriteGroup<SAPSprite>();

		add(ground);
		add(ammo);
		add(port);
		add(bombs);
		add(enemy);

		portBar = new FlxBar(0, 0, LEFT_TO_RIGHT, Math.round(FlxG.width * 0.5), 20, this.port, 'health', 0, port.health, true);
		enemyBar = new FlxBar(0, 0, LEFT_TO_RIGHT, Math.round(FlxG.width * 0.5), 20, this.enemy, 'health', 0, enemy.health, true);

		portBar.createFilledBar(FlxColor.RED, FlxColor.MAGENTA, true, FlxColor.BLACK, 2);
		enemyBar.createFilledBar(FlxColor.GRAY, FlxColor.RED, true, FlxColor.BLACK, 2);

		portBar.screenCenter(X);
		enemyBar.screenCenter(X);

		enemyBar.y = (enemyBar.height * 2);
		portBar.y = FlxG.height - (portBar.height * 2);

		add(portBar);
		add(enemyBar);
	}

	var tick = 0;

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		tick++;

		if (tick != 0 && tick % 25 == 0 && Save.random.bool(30))
		{
			spawnObstacle(Save.random.bool((1 / 10) * 100));
		}

		if (Control.GAME_JUMP.justPressed && port.gravity == 0) port.gravity = port.gravityMax;

		for (i => obstacles in [bombs, ammo])
		{
			var bomb = i == 0;

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

					if (bomb)
					{
						port.health--;
					}
					else {}

					continue;
				}
			}
		}

		if (port.health < 1)
		{
			throw 'Boom. Boom. Boom. You\'re dead.';
		}

		if (enemy.health < 1)
		{
			throw 'Boom. Youre dead.';
		}
	}

	function spawnObstacle(ammo = false)
	{
		// trace('Spawning ${(ammo) ? 'Ammo' : 'Bomb'}');

		var obstacle = new SAPSprite().makeGraphic(32, 32, (ammo) ? FlxColor.YELLOW : FlxColor.GRAY);
		obstacle.setPosition(FlxG.width + (obstacle.width * 2), port.gravityRegion.height);

		if (Save.random.bool())
		{
			obstacle.y -= obstacle.height * 3;
		}

		if (ammo)
		{
			this.ammo.add(obstacle);
			return;
		}

		bombs.add(obstacle);
	}
}
