package maki.sap_mingled.assets.graphics;

import flixel.FlxG;
import flixel.system.FlxAssets;
import openfl.system.System;
import openfl.text.TextField;
import openfl.text.TextFormat;

class DebugText extends TextField
{
	/**
		The current frame rate, expressed using frames-per-second
	**/
	public var currentFPS(default, null):Int;

	@:noCompletion private var cacheCount:Int;
	@:noCompletion private var currentTime:Float;
	@:noCompletion private var times:Array<Float>;
	@:noCompletion private var lastText:String = null;

	override public function new(x:Float = 10, y:Float = 10, color:Int = 0x000000)
	{
		super();

		this.x = x;
		this.y = y;

		selectable = false;
		mouseEnabled = false;
		defaultTextFormat = new TextFormat(FlxAssets.FONT_DEFAULT, 8, color);
		background = true;
		backgroundColor = 0xFF808080;

		currentFPS = 0;
		cacheCount = 0;
		currentTime = 0;
		times = [];
	}

	override function __enterFrame(deltaTime:Float)
	{
		currentTime += deltaTime;
		times.push(currentTime);

		while (times[0] < currentTime - 1000) times.shift();

		var currentCount = times.length;
		currentFPS = Std.int((currentCount + cacheCount) / 2);

		if (currentCount != cacheCount)
		{
			var lines = [
				'FPS: ${currentFPS}',
				#if SAPM_MEMORY_COUNTER
				'Memory: ${System.totalMemoryNumber}'
				#end
			];

			var longest = -1;

			for (i => line in lines) if (line.length > lines[longest]?.length ?? 0) longest = i;

			var newText = lines.join('\n');

			if (newText != lastText)
			{
				text = newText;
				lastText = newText;

				width = textWidth * 1.1;
				height = textHeight * 1.1;

				if (width > FlxG.width / 4) width = FlxG.width / 4;
				if (height > FlxG.height / 4) height = FlxG.height / 4;
			}
		}

		cacheCount = currentCount;
	}
}
