package maki.sap_mingled.assets.graphics;

import flixel.FlxG;
import flixel.math.FlxRect;
import flixel.FlxSprite;
import flixel.util.FlxColor;

class SAPSprite extends FlxSprite
{
	override function makeGraphic(width:Int, height:Int, color:FlxColor = FlxColor.WHITE, unique:Bool = false,
			?key:String):SAPSprite return cast super.makeGraphic(width, height, color, unique, key);

	/**
	 * Positive goes up
	 * Negative goes down
	 */
	public var gravity:Float = 0;

	public var gravityMin:Float = 0;

	public function setGravityMin(_gravityMin:Float):SAPSprite
	{
		gravityMin = _gravityMin;
		return this;
	}

	public var gravityMax:Float = 0;

	public function setGravityMax(_gravityMax:Float):SAPSprite
	{
		gravityMax = _gravityMax;
		return this;
	}

	public function setGravityMinMax(_gravityMin:Float, _gravityMax:Float):SAPSprite
	{
		gravityMin = _gravityMin;
		gravityMax = _gravityMax;
		return this;
	}

	public var gravityConstant:Float = 0;

	public function setGravityConstant(_gravityConstant:Float):SAPSprite
	{
		gravityConstant = _gravityConstant;
		return this;
	}

	public var gravityEnabled:Bool = false;

	public function enableGravity():SAPSprite
	{
		gravityEnabled = true;
		return this;
	}

	public function disableGravity():SAPSprite
	{
		gravityEnabled = false;
		return this;
	}

	public var gravityRegion:FlxRect = FlxRect.get(0, 0, FlxG.width, FlxG.height);

	public function setGravityRegion(x = 0.0, y = 0.0, width = 0.0, height = 0.0):SAPSprite
	{
		gravityRegion = new FlxRect(x, y, width, height);
		return this;
	}

	public var forceGravityRegion:Bool = false;

	public function enableForcedGravityRegion():SAPSprite
	{
		forceGravityRegion = true;
		return this;
	}

	public function disableForcedGravityRegion():SAPSprite
	{
		forceGravityRegion = false;
		return this;
	}

	public var withinGravityRegion(get, null):Bool;

	function get_withinGravityRegion():Bool
	{
		return this.x >= gravityRegion.x
			&& this.x <= gravityRegion.width
			&& this.y >= gravityRegion.y
			&& this.y <= gravityRegion.height;
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (gravityEnabled)
		{
			gravity = Math.min(Math.max(gravity - gravityConstant, gravityMin), gravityMax);
			if (gravity != 0) applyGravity();
		}
	}

	public function applyGravity()
	{
		this.y -= gravity;
		if (!withinGravityRegion)
		{
			gravity = 0;

			if (forceGravityRegion)
			{
				this.x = Math.min(Math.max(this.x, gravityRegion.x), gravityRegion.width);
				this.y = Math.min(Math.max(this.y, gravityRegion.y), gravityRegion.height);
			}
		}
		this.y += gravity;

		if (withinGravityRegion && gravity != 0)
		{
			trace('Applied gravity: $gravity');
			this.y -= gravity;
		}
	}
}
