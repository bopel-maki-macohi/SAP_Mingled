package maki.sap_mingled.states.menus.title;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxState;
import flixel.addons.display.FlxBackdrop;
import flixel.group.FlxSpriteContainer.FlxTypedSpriteContainer;
import flixel.text.FlxText;

class TitleState extends FlxState
{
	var protoBG:FlxBackdrop;
	var protoLogo:FlxText;

	var buttons:FlxTypedSpriteContainer<TitleButton>;
	var buttonsCam:FlxCamera;
	var buttonsCamFollow:FlxObject;
	var entries:Array<String> = ['Play', 'Options', 'Credits',];

	var selection:Int = 0;

	override function create()
	{
		super.create();

		protoBG = new FlxBackdrop(get_path_game_menus('grid/${Save.data?.ui?.grid_skin ?? 'modern'}'));
		protoBG.setGraphicSize(32);
		add(protoBG);

		protoBG.velocity.set(16, 16);

		protoLogo = new FlxText(0, 0, 0, Constants.GAME_TITLE, 32);
		add(protoLogo);
		protoLogo.screenCenter();

		protoLogo.setBorderStyle(OUTLINE_CARDINAL, 0xFF000000, 4);

		protoLogo.y -= protoLogo.height * 4;

		buttons = new FlxTypedSpriteContainer<TitleButton>();
		add(buttons);

		var i = 0;
		for (entry in entries)
		{
			if (entry == null) continue;
			if (entry?.trim()?.length < 1) continue;

			var entry_button = new TitleButton(entry, i);
			buttons.add(entry_button);

			i++;
		}

		buttonsCam = new FlxCamera();
		FlxG.cameras.add(buttonsCam, false);
		buttonsCam.bgColor = 0x00000000;

		buttons.cameras = [buttonsCam];

		buttonsCamFollow = new FlxObject(FlxG.width / 2);
		add(buttonsCamFollow);

		buttonsCam.follow(buttonsCamFollow, LOCKON, 0.04);
		buttonsCam.focusOn(buttonsCamFollow.getPosition());
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		for (button in buttons)
		{
			button.screenCenter(X);
			button.y = (button.ID * button.size * 2);
			button.updateSelection(selection);
		}

		if (Controls.justPressed('ui_up')) changeSelection(-1);
		if (Controls.justPressed('ui_down')) changeSelection(1);
	}

	function changeSelection(amount:Int)
	{
		selection += amount;

		if (selection < 0) selection = buttons.length - 1;
		if (selection > buttons.length - 1) selection = 0;
	}
}
