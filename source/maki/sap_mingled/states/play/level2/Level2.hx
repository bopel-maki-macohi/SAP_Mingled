package maki.sap_mingled.states.play.level2;

import flixel.FlxSprite;
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
	var zaps:FlxTypedSpriteGroup<FlxSprite>;
	var protection:FlxTypedSpriteGroup<FlxSprite>;
	var enemy:FlxSprite;
	var sinco:FlxSprite;

	override function create()
	{
		super.create();

		zaps = new FlxTypedSpriteGroup<FlxSprite>();
		protection = new FlxTypedSpriteGroup<FlxSprite>();
		enemy = new FlxSprite();
		sinco = new FlxSprite();

		sinco.makeGraphic(32, 32, FlxColor.LIME);

		add(zaps);
		add(protection);
		add(enemy);
		add(sinco);
	}
}
