package maki.sap_mingled.states.menus.options;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.group.FlxSpriteContainer.FlxTypedSpriteContainer;

@localePrefix('menus.options')
class OptionsMenuState extends SAPState
{
	var buttons:FlxTypedSpriteContainer<MenuButton>;
	var buttonsCam:FlxCamera;
	var buttonsCamFollow:FlxObject;

	var order = [];
	var entries:Map<String, FuncVoid> = [];
	var entryText:Map<String, FuncInOutput<String, String>> = [];

	function newentry(entry:String, accept:FuncVoid, text:FuncInOutput<String, String>)
	{
		if (entry == null || accept == null || text == null) return;

		order.push(entry);
		entries.set(entry, accept);
		entryText.set(entry, text);
	}

	override public function new()
	{
		super();

		newentry('Grid Skin',
			() -> GridBG.instance?.setSkin(Save.data.ui.grid_skin = OptionsUtil.array_option(Save.data.ui.grid_skin, OptionsUtil.grid_skins)),
			(entry) -> return OptionsUtil.option_text('${getClassLocalePrefix(this)}.${entry.toLowerCase()}', Save.data.ui.grid_skin),);

		newentry('Debug Display', () -> Save.data.ui.debug_display = OptionsUtil.bool_option(Save.data.ui.debug_display),
			(entry) -> return OptionsUtil.option_text('${getClassLocalePrefix(this)}.${entry.toLowerCase()}', Save.data.ui.debug_display),);
	}

	var selection:Int = 0;

	override function create()
	{
		super.create();

		add(new GridBG());

		buttons = new FlxTypedSpriteContainer<MenuButton>();
		add(buttons);

		var i = 0;
		for (entry in order)
		{
			if (entry == null) continue;
			if (entry?.trim()?.length < 1) continue;

			var entry_button = new MenuButton('', i, entries.get(entry));
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

		if (Controls.justPressed('ui_back'))
		{
			outroDelay = SAPAudioManager.playSound({
				path: get_path_game_sounds('cancel')
			})?.length / 2000 ?? 0;
			FlxG.switchState(() -> new TitleState());
		}
		for (button in buttons)
		{
			var entry = order[button.ID];

			button.text = entryText.get(entry)(entry);
			button.screenCenter(X);
			button.y = (button.ID * button.size * 2);
			button.updateSelection(selection);

			buttonsCamFollow.y = button.y;
		}

		if (Controls.justPressed('ui_up')) changeSelection(-1);
		if (Controls.justPressed('ui_down')) changeSelection(1);

		if (Controls.justPressed('ui_accept'))
		{
			outroDelay = SAPAudioManager.playSound({
				path: get_path_game_sounds('select')
			})?.length / 2000 ?? 0;

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
