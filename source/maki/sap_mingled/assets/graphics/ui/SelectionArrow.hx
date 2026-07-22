package maki.sap_mingled.assets.graphics.ui;

import flixel.FlxSprite;

class SelectionArrow extends FlxSprite
{
	public var selected(default, set):Bool;

	function set_selected(_selected:Bool):Bool
	{
		if (_selected) animation.play('selected');
		else animation.play('unselected');

		return selected = _selected;
	}

	override public function new(graphic_size = 16, x = 0.0, y = 0.0)
	{
		super(x, y);

		loadGraphic(get_path_game_menus('selectionArrow'), true, 8, 8);
		animation.add('selected', [0]);
		animation.add('unselected', [1]);

		setGraphicSize(graphic_size);
		updateHitbox();

		selected = false;
	}
}
