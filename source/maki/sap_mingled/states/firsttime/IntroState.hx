package maki.sap_mingled.states.firsttime;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

class IntroState extends FlxState
{
	var cutsceneAsset = new FlxSprite();

	override function create()
	{
		super.create();

		cutsceneAsset.loadGraphic(get_path_game_cutscene('intro'));
		add(cutsceneAsset);

		cutsceneAsset.screenCenter();
		cutsceneAsset.alpha = 0;

		SAPAudioManager.playMusic({
			path: get_path_ost('BigBang'),
			looped: false,

			on_start: onCutsceneStart,
			on_complete: onCutsceneEnd,
		});
	}

	function onCutsceneStart()
	{
		var cutsceneHalfLength = (FlxG.sound.music.length / 2000) ?? 1;
		if (cutsceneHalfLength < 1) cutsceneHalfLength = 1;

		FlxTween.tween(cutsceneAsset, {alpha: 1}, cutsceneHalfLength, {
			ease: FlxEase.sineInOut,
		});

		FlxTween.tween(cutsceneAsset, {alpha: 0}, cutsceneHalfLength, {
			ease: FlxEase.sineInOut,
			startDelay: cutsceneHalfLength,
		});
	}

	function onCutsceneEnd()
	{
		FlxG.switchState(StartingState.get());
	}
}
