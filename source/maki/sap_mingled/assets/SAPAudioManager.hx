package maki.sap_mingled.assets;

import flixel.FlxG;
import flixel.sound.FlxSound;

class SAPAudioManager
{
	/**
	 * List of currently playing sounds
	 * 
	 * Does not include `music`
	 */
	public static var sounds:Array<FlxSound> = [];

	public static var music:FlxSound;

	public static function createSound():FlxSound
	{
		var sound = new FlxSound();

		FlxG.sound.list.add(sound);

		return sound;
	}

	public static function playSound(params:PlaySoundParam)
	{
		if (params == null) return;

		var sound = createSound();

		final fadeIn = params.fade_in && params.fade_in_duration > 0.0;

		function loadSound()
		{
			sound.load(params.path);

			sound.setup(1.0, false);
		}

		function playTheSound()
		{
			loadSound();

			if (fadeIn) sound.fadeIn(params.fade_in_duration, 0, 1);
			else sound.play();
		}

		playTheSound();
	}

	public static function playMusic(params:PlayMusicParams)
	{
		if (params == null) return;

		if (music == null)
		{
			music = createSound();
		}

		final fadeIn = params.fade_in && params.fade_in_duration > 0.0;
		final fadeOut = params.fade_out && params.fade_out_duration > 0.0;

		function loadMusic()
		{
			music.load(params.path);

			var loopUntil:NullInt = params?.loopUntil ?? -1;

			if (loopUntil != null) music.setup(1.0, loopUntil);
			else music.setup(1.0, params?.looped == true);
		}

		function playTheMusic()
		{
			loadMusic();

			if (fadeIn) music.fadeIn(params.fade_in_duration, 0, 1);
			else music.play();
		}

		if (music.playing && fadeOut)
		{
			music.fadeOut(params.fade_out_duration, 0, function(t)
			{
				playTheMusic();
			});
		}
		else playTheMusic();
	}
}
