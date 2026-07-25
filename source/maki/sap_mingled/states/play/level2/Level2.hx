package maki.sap_mingled.states.play.level2;

import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
import flixel.util.FlxColor;

/**
 * Sinco stand on a rock
 * 
 * The enemy flies above, spawning protection and attacks.
 * 
 * The protection has to be dealt with first before the enemy via Sinco zapping them.
 */
class Level2 extends Level
{
	var zaps:FlxTypedSpriteGroup<SAPSprite>;
	var protection:FlxTypedSpriteGroup<SAPSprite>;
	var enemy:SAPSprite;
	var sinco:SAPSprite;

	override function create()
	{
		super.create();

		zaps = new FlxTypedSpriteGroup<SAPSprite>();
		protection = new FlxTypedSpriteGroup<SAPSprite>();
		enemy = new SAPSprite();
		sinco = new SAPSprite();

		sinco.makeGraphic(32, 32, FlxColor.LIME);

		add(zaps);
		add(protection);
		add(enemy);
		add(sinco);
	}
}
