package maki.sap_mingled.states.firsttime;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

class IntroState extends FlxState
{
	override function create()
	{
		super.create();

		var cutsceneAsset = new FlxSprite();
		cutsceneAsset.loadGraphic(get_path_game_cutscene('intro'));
		add(cutsceneAsset);
		cutsceneAsset.screenCenter();
		cutsceneAsset.alpha = 0;
		var cutsceneHalfLength = (FlxG.sound.music?.length / 2) ?? 1;

		SAPAudioManager.playMusic({
			path: get_path_ost('BigBang'),
			looped: false,
		});

		FlxTween.tween(cutsceneAsset, {alpha: 1}, cutsceneHalfLength, {
			ease: FlxEase.sineInOut,
		}).then(FlxTween.tween(cutsceneAsset, {alpha: 0}, cutsceneHalfLength, {
			ease: FlxEase.sineInOut,
			onComplete: function(t)
			{
				cutsceneComplete();
			}
		}));
	}

	function cutsceneComplete()
	{
		trace('cutscene done');
	}
}
