package maki.sap_mingled.states.menus.play;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.group.FlxSpriteContainer.FlxTypedSpriteContainer;
import flixel.text.FlxText;
import flixel.util.FlxColor;

@localePrefix('menus.play')
class PlayMenuState extends SAPState
{
	var icons:FlxTypedSpriteContainer<LevelIcon>;
	var iconsCam:FlxCamera;
	var iconsCamFollow:FlxObject;

	var order = [
		'unknown',
		'unknown',
		'unknown',
		'unknown',
		'unknown',
		'unknown',
		'unknown',
		'unknown',
		'unknown',
		'unknown',
	];

	var selection = 0;

	var selectionText:FlxText;

	override function create()
	{
		super.create();

		add(new GridBG());

		icons = new FlxTypedSpriteContainer<LevelIcon>();
		iconsCam = new FlxCamera();
		iconsCamFollow = new FlxObject(0, FlxG.height / 8);

		FlxG.cameras.add(iconsCam, false);
		iconsCam.bgColor = FlxColor.TRANSPARENT;

		add(iconsCamFollow);

		iconsCam.follow(iconsCamFollow, LOCKON, 0.04);
		iconsCam.focusOn(iconsCamFollow.getPosition());

		icons.cameras = [iconsCam];
		add(icons);

		for (i => entry in order)
		{
			var icon = new LevelIcon(entry, i);
			icons.add(icon);
		}

		selectionText = new FlxText(0, 0, FlxG.width, '2parkeR', 32);
		add(selectionText);
		selectionText.alignment = CENTER;
		selectionText.setBorderStyle(OUTLINE_CARDINAL, 0xFF000000, 4);
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (SAPAudioManager.canPlayMusic && SAPAudioManager.currentTrack != get_path_ost('TwentyFive')) SAPAudioManager.playMusic({
			path: get_path_ost('TwentyFive')
		});

		if (Controls.justPressed('ui_back'))
		{
			outroDelay = SAPAudioManager.playSound({
				path: get_path_game_sounds('cancel')
			})?.length / 2000 ?? 0;
			FlxG.switchState(() -> new TitleState());
		}

		for (icon in icons)
		{
			icon.x = (icon.ID * icon.width);

			icon.color = FlxColor.WHITE;
			if (selection == icon.ID)
			{
				iconsCamFollow.x = icon.x;
				icon.color = FlxColor.YELLOW;
			}
		}

		if (Controls.justPressed('ui_left')) changeSelection(-1);
		if (Controls.justPressed('ui_right')) changeSelection(1);

		selectionText.text = getLanguageKey('level.${order[selection]}.title');
		selectionText.screenCenter();
		selectionText.y -= selectionText.height * 2;
	}

	function changeSelection(amount:Int)
	{
		selection += amount;

		if (selection < 0) selection = icons.length - 1;
		if (selection > icons.length - 1) selection = 0;

		SAPAudioManager.playSound({
			path: get_path_game_sounds('scroll')
		});
	}
}
