package maki.sap_mingled.assets.graphics.ui;

import flixel.FlxSprite;

class SelectionArrow extends FlxSprite
{
	public var selected(default, set):Bool;

	function set_selected(_selected:Bool):Bool
	{
		if (animation.name != 'select' )
		{
			if (_selected)
			{
				if (animation.name != 'selected') animation.play('selected');
			}
			else
			{
				if (animation.name != 'unselected') animation.play('unselected');
			}
		}

		return selected = _selected;
	}

	override public function new(graphicSize = 16, x = 0.0, y = 0.0)
	{
		super(x, y);

		loadGraphic(get_path_game_menus('selectionArrow'), true, 8, 8);
		animation.add('selected', [0, 2], 24);
		animation.add('unselected', [1]);
		animation.add('select', [3], 4, false);

		animation.play('unselected');

		animation.onFinish.add(function(anim)
		{
			if (anim == 'select') animation.play('selected');
		});

		setGraphicSize(graphicSize);
		updateHitbox();

		selected = false;
	}
}
