package maki.sap_mingled.states.menus.options;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;

@localePrefix('menus.options.controls')
class ControlOptionSubState extends SAPSubState
{
	var control:String;

	public function new(control = '')
	{
		super();

		this.control = control;
	}

	var substateCam:FlxCamera;
	var bg:SAPSprite;

	var rebindingText:FlxText;

	override function create()
	{
		super.create();

		substateCam = new FlxCamera();
		FlxG.cameras.add(substateCam, false);
		substateCam.bgColor = FlxColor.TRANSPARENT;

		bg = new SAPSprite();
		bg.makeGraphic(Math.round(FlxG.width * 1.1), Math.round(FlxG.height * 1.1), FlxColor.BLACK);
		bg.alpha = 0;
		add(bg);

		FlxTween.tween(bg, {alpha: 0.75}, 1, {
			ease: FlxEase.quintOut,
		});

		bg.cameras = [substateCam];

		final langKey = '${getClassLocalePrefix(this)}.${control.toLowerCase()}';

		rebindingText = new FlxText(0, 0, 0, '', 16);
		rebindingText.text = getLanguageKey('${getClassLocalePrefix(this)}.rebinding').replace('%1', getLanguageKey(langKey))
			.replace('%2', Reflect.field(Save.data.controls, control));
		add(rebindingText);
		rebindingText.screenCenter();
		rebindingText.alpha = 0;

		rebindingText.cameras = [substateCam];

		FlxTween.tween(rebindingText, {alpha: 1}, 1, {
			ease: FlxEase.quintOut,
		});
	}
}
