package maki.sap_mingled.assets.graphics;

import flixel.addons.display.FlxBackdrop;
import flixel.math.FlxPoint;

class GridBG extends FlxBackdrop
{
	public static var POSITION:FlxPoint;

	override public function new()
	{
		super();

		if (POSITION == null) POSITION = new FlxPoint();
		else setPosition(POSITION.x, POSITION.y);

		setSkin(Save.data?.ui?.grid_skin ?? 'modern');
	}

	public function setSkin(skin:String)
	{
		loadGraphic(get_path_game_menus('grid/$skin'));
		setGraphicSize(32);
		velocity.set(16, 16);
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		POSITION.set(this.x, this.y);
	}
}
