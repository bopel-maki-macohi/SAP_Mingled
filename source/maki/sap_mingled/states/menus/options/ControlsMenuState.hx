package maki.sap_mingled.states.menus.options;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.group.FlxSpriteContainer.FlxTypedSpriteContainer;

@localePrefix('menus.options.controls')
class ControlsMenuState extends SAPState
{
	var buttons:FlxTypedSpriteContainer<MenuButton>;
	var controlsButtonsCam:FlxCamera;
	var controlsButtonsCamFollow:FlxObject;

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

		var controls = Reflect.fields(Save.data.controls);
		controls.sort((a, b) -> return SortUtil.alphabetically(a, b));

		for (control in controls)
		{
			newentry(control, function()
			{
				trace(control);
			},
				(entry) -> return OptionsUtil.option_text('${getClassLocalePrefix(this)}.${entry.toLowerCase()}', Reflect.field(Save.data.controls, control)),);
		}
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

		controlsButtonsCam = new FlxCamera();
		FlxG.cameras.add(controlsButtonsCam, false);
		controlsButtonsCam.bgColor = 0x00000000;

		buttons.cameras = [controlsButtonsCam];

		controlsButtonsCamFollow = new FlxObject(FlxG.width / 2);
		add(controlsButtonsCamFollow);

		controlsButtonsCam.focusOn(controlsButtonsCamFollow.getPosition());
		controlsButtonsCam.follow(controlsButtonsCamFollow, LOCKON, 0.04);
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
			FlxG.switchState(() -> new OptionsMenuState());
		}
		for (button in buttons)
		{
			var entry = order[button.ID];

			button.text = entryText.get(entry)(entry);
			button.screenCenter(X);
			button.y = (button.ID * button.size * 2);
			button.updateSelection(selection);

			controlsButtonsCamFollow.y = button.y;
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
