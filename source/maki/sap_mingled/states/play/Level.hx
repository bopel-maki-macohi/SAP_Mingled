package maki.sap_mingled.states.play;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;

class Level extends SAPState
{
	override function new()
	{
		super();

		SAPAudioManager.stopMusic();
	}

	public var paused(default, null):Bool = false;

	public var pausedTick:Int = 0;
	public var unpausedTick:Int = 0;

	public var pauseScreenInit:Bool = false;
	public var pauseScreenCam:FlxCamera;
	public var canTogglePaused:Bool = true;

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		FlxG.watch.addQuick('pausedTick', pausedTick);
		FlxG.watch.addQuick('unpausedTick', unpausedTick);

		if (canTogglePaused && Controls.justPressed('game_pause'))
		{
			paused = !paused;

			if (paused && !pauseScreenInit)
			{
				initPauseScreen();
				pauseScreenInit = true;
			}

			if (paused) onPause();
			if (!paused) onUnpause();
		}

		if (paused) pausedUpdate(elapsed);
		else unpausedUpdate(elapsed);
	}

	function pausedUpdate(elapsed:Float)
	{
		pausedTick++;
	}

	function unpausedUpdate(elapsed:Float)
	{
		unpausedTick++;
	}

	function initPauseScreen()
	{
		var darkBG = new SAPSprite().makeGraphic(Math.floor(FlxG.width * 1.1), Math.floor(FlxG.height * 1.1), FlxColor.BLACK);
		darkBG.alpha = 0.75;
		add(darkBG);

		var PAUSED = new FlxText(0, 0, 0, 'PAUSED', 32);
		add(PAUSED);
		PAUSED.screenCenter();

		pauseScreenCam = new FlxCamera();
		FlxG.cameras.add(pauseScreenCam, false);
		pauseScreenCam.bgColor = FlxColor.TRANSPARENT;

		darkBG.cameras = PAUSED.cameras = [pauseScreenCam];

		pauseScreenCam.alpha = 0;
	}

	function onPause()
	{
		FlxTween.cancelTweensOf(pauseScreenCam);
		FlxTween.tween(pauseScreenCam, {alpha: 1}, 0.25, {ease: FlxEase.quintOut});
	}

	function onUnpause()
	{
		FlxTween.cancelTweensOf(pauseScreenCam);
		FlxTween.tween(pauseScreenCam, {alpha: 0}, 0.25, {ease: FlxEase.quintOut});
	}
}
