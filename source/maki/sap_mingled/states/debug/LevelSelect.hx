package maki.sap_mingled.states.debug;

import flixel.FlxG;
import flixel.text.FlxText;

class LevelSelect extends SAPState
{
	var levels = ['level1',];
	var sel = 0;

	var levelText = new FlxText();

	override function create()
	{
		super.create();

		levelText.size = 16;
		add(levelText);

		levelText.text = levels[sel];
		if (levels.length == 1) accept();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (Control.UI_LEFT.justPressed) sel--;
		if (Control.UI_RIGHT.justPressed) sel++;

		if (sel < 0) sel = levels.length - 1;
		if (sel > levels.length - 1) sel = 0;

		levelText.text = levels[sel];
		levelText.screenCenter();

		if (Control.UI_ACCEPT.justPressed) accept();
	}

	function accept()
	{
		trace(levelText.text);

		switch (levelText.text)
		{
			case 'level1': FlxG.switchState(() -> new Level1());
		}
	}
}
