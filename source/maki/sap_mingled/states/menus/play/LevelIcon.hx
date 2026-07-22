package maki.sap_mingled.states.menus.play;

import flixel.FlxSprite;

class LevelIcon extends FlxSprite
{
	public function new(icon = 'unknown', x = 0.0, y = 0.0)
	{
		super(x, y);

		loadGraphic(get_path_game_menus_play('levelIcons/$icon'));
	}
}
