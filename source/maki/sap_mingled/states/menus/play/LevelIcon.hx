package maki.sap_mingled.states.menus.play;

import flixel.FlxSprite;

class LevelIcon extends FlxSprite
{
	public function new(icon = 'unknown', ID:Int)
	{
		super(x, y);

		loadGraphic(get_path_game_menus_play('levelIcons/${icon ?? 'unknown'}'));

		this.ID = ID;
	}
}
