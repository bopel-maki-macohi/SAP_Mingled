package maki.sap_mingled.assets.shaders;

import flixel.addons.display.FlxRuntimeShader;
import flixel.util.FlxColor;
import lime.utils.Assets;

class ReplaceColorShader extends FlxRuntimeShader
{
	override public function new(on = true, target = FlxColor.BLACK, replacement = FlxColor.WHITE)
	{
		super(Assets.getText(get_path_shaders('replaceColor')));

		setOn(on);
		setTargetColor(target ?? FlxColor.BLACK);
		setReplacementColor(replacement ?? FlxColor.WHITE);
	}

	public function setTargetColor(color:FlxColor)
	{
		this.setFloatArray('target', [color.redFloat, color.greenFloat, color.blueFloat, color.alphaFloat]);
	}

	public function setReplacementColor(color:FlxColor)
	{
		this.setFloatArray('replacement', [color.redFloat, color.greenFloat, color.blueFloat, color.alphaFloat]);
	}

	public function getTargetColor():Int
	{
		var target = this.getFloatArray('target');
		return FlxColor.fromRGBFloat(target[0], target[1], target[2], target[3]);
	}

	public function getReplacementColor():Int
	{
		var replacement = this.getFloatArray('replacement');
		return FlxColor.fromRGBFloat(replacement[0], replacement[1], replacement[2], replacement[3]);
	}

	public function setOn(on = true)
	{
		this.setBool('on', on);
	}
}
