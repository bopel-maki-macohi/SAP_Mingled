package maki.sap_mingled.assets;

import flixel.FlxG;
import flixel.sound.FlxSound;

class SAPAudioManager
{
	public static function playSound(params:PlaySoundParam)
	{
		if (params == null) return;

		final fadeIn = params.fade_in && params.fade_in_duration > 0.0;

		var sound = FlxG.sound.play(params.path, 1.0, false, null, true, params.on_complete);

		if (params.on_start != null) params.on_start();

		if (fadeIn) sound.fadeIn(params.fade_in_duration, 0, 1);
		else sound.play();
	}

	public static function playMusic(params:PlayMusicParams)
	{
		if (params == null) return;

		var music = FlxG.sound.playMusic(params.path, null, 1.0, params?.looped == true, params.on_complete);

		final fadeIn = params.fade_in && params.fade_in_duration > 0.0;
		final fadeOut = params.fade_out && params.fade_out_duration > 0.0;

		function playTheMusic()
		{
			if (params.on_start != null) params.on_start();

			if (fadeIn) music.fadeIn(params.fade_in_duration, 0, 1);
			else music.play();
		}

		if (music?.playing && fadeOut)
		{
			music.fadeOut(params.fade_out_duration, 0, function(t)
			{
				playTheMusic();
			});
		}
		else playTheMusic();
	}
}
