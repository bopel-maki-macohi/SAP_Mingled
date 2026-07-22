package maki.sap_mingled.states.menus.title;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.group.FlxSpriteContainer.FlxTypedSpriteContainer;
import flixel.text.FlxText;

@localePrefix('menus.title')
class TitleState extends SAPState
{
	var protoLogo:FlxText;

	var versionText:FlxText;

	var buttons:FlxTypedSpriteContainer<MenuButton>;
	var buttonsCam:FlxCamera;
	var buttonsCamFollow:FlxObject;

	var order = [
		'Play',
		'Options',
		// 'Credits',
	];
	var entries:Map<String, FuncVoid> = [
		'Play' => function()
		{
			FlxG.switchState(() -> new PlayMenuState());
		},
		'Options' => function()
		{
			FlxG.switchState(() -> new OptionsMenuState());
		},
		'Credits' => function()
		{
			trace('Credits');
		},
	];

	var selection:Int = 0;

	public static var rememberedSelection = 0;

	override function create()
	{
		super.create();

		selection = rememberedSelection;

		add(new GridBG());

		protoLogo = new FlxText(0, 0, FlxG.width, Constants.GAME_TITLE, 32);
		add(protoLogo);
		protoLogo.alignment = CENTER;
		protoLogo.screenCenter();

		protoLogo.setBorderStyle(OUTLINE_CARDINAL, 0xFF000000, 4);

		protoLogo.y -= protoLogo.height * 4;

		buttons = new FlxTypedSpriteContainer<MenuButton>();
		add(buttons);

		var i = 0;
		for (entry in order)
		{
			if (entry == null) continue;
			if (entry?.trim()?.length < 1) continue;

			var entry_button = new MenuButton(getLanguageKey('${getClassLocalePrefix(this)}.option.${entry.toLowerCase()}'), i, entries.get(entry));
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

		versionText = new FlxText(0, 0, FlxG.width / 8, 'v${Constants.GAME_VERSION}', 16);
		add(versionText);
		versionText.x = 4;
		versionText.y = FlxG.height - versionText.height;
		versionText.setBorderStyle(OUTLINE_CARDINAL, 0xFF000000, 2);
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

		if (Controls.justPressed('ui_accept'))
		{
			outroDelay = SAPAudioManager.playSound({
				path: get_path_game_sounds('select')
			})?.length / 2000 ?? 0;

			rememberedSelection = selection;

			for (button in buttons) button.select(selection);
		}
	}

	function changeSelection(amount:Int)
	{
		selection += amount;

		if (selection < 0) selection = buttons.length - 1;
		if (selection > buttons.length - 1) selection = 0;

		SAPAudioManager.playSound({
			path: get_path_game_sounds('scroll')
		});
	}
}
