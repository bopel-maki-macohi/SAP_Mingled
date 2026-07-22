package maki.sap_mingled.assets.graphics.ui;

import flixel.FlxSprite;
import flixel.text.FlxText;

class MenuButton extends FlxText
{
	var arrow:SelectionArrow;

	var background:FlxSprite;

	var onSelect:FuncVoid;

	override public function new(text:String, ID:Int, ?onSelect:FuncVoid)
	{
		super(0, 0, 0, text, 32);

		arrow = new SelectionArrow(32);

		background = new FlxSprite().makeGraphic(1, 1, 0xFF000000);

		this.ID = ID;
		this.onSelect = onSelect;
	}

	override function draw()
	{
		if (arrow != null)
		{
			arrow.cameras = cameras;
			arrow.setPosition(this.x - arrow.width, this.getGraphicMidpoint().y - (arrow.height / 2));
		}

		if (background != null)
		{
			background.cameras = cameras;
			background.scale.set(width + arrow.width, height);
			background.updateHitbox();

			background.setPosition(this.x - arrow.width, this.y);
			background.draw();
		}

		if (arrow != null) arrow.draw();

		super.draw();
	}

	public function updateSelection(currentSelected:Int)
	{
		if (arrow == null) return;

		arrow.selected = ID == currentSelected;
	}

	public function select(currentSelected:Int)
	{
		if (onSelect == null) return;
		if (currentSelected == ID) onSelect();
	}
}
