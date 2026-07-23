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

	public function setTargetColor(color:Int)
	{
		var red:Float = ((color >> 16) & 0xff) / 255;
		var green:Float = ((color >> 8) & 0xff) / 255;
		var blue:Float = (color & 0xff) / 255;
		this.setFloatArray('target', [red, green, blue]);
	}

	public function setReplacementColor(color:Int)
	{
		var red:Float = ((color >> 16) & 0xff) / 255;
		var green:Float = ((color >> 8) & 0xff) / 255;
		var blue:Float = (color & 0xff) / 255;
		this.setFloatArray('replacement', [red, green, blue]);
	}

	public function getTargetColor():Int
	{
		var target = this.getFloatArray('target');
		return FlxColor.fromRGBFloat(target[0], target[1], target[2]);
	}

	public function getReplacementColor():Int
	{
		var replacement = this.getFloatArray('replacement');
		return FlxColor.fromRGBFloat(replacement[0], replacement[1], replacement[2]);
	}

	public function setOn(on = true)
	{
		this.setBool('on', on);
	}
}
