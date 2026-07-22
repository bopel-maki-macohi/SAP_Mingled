package maki.sap_mingled.assets.graphics;

import flixel.FlxG;
import flixel.math.FlxMath;
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
		backgroundColor = 0x50000000;

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
			final memory = #if (openfl >= "9.4.0") System.totalMemoryNumber #else System.totalMemory #end;

			var lines = [
				'FPS: ${currentFPS}',
				#if SAPM_MEMORY_COUNTER
				'Memory: ${FlxMath.roundDecimal((memory / 1024) / 1000, 1)} MB'
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
				height = textHeight * 1.2;

				if (width > FlxG.width / 4) width = FlxG.width / 4;
			}
		}

		cacheCount = currentCount;
	}
}
