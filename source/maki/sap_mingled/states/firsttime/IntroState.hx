package maki.sap_mingled.states.firsttime;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
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
		var cutsceneLength = (FlxG.sound.music?.length / 2) ?? 1;

		SAPAudioManager.playMusic({
			path: get_path_ost('BigBang'),
		});

		FlxTween.tween(cutsceneAsset, {alpha: 1}, cutsceneLength).then(FlxTween.tween(cutsceneAsset, {alpha: 0}, cutsceneLength, {
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
