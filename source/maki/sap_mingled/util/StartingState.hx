package maki.sap_mingled.util;

import flixel.util.typeLimit.NextState.InitialState;

class StartingState
{
	public static function get():InitialState
	{
		#if SAPM_START_INTRO

		/**
		 * 	Save this for when theres
		 * 	something worth warning people about.
		 * 	
		 * 	Example: Flashing lights
		 */
		/**
			if (!Save.data.game.persistance_keys.contains(SavePersistanceKey.GLOBAL_FIRST_TIME))
			{
				Save.addGlobalPersistanceKey(SavePersistanceKey.GLOBAL_FIRST_TIME);

				return FirstTimeState;
			}
		 */

		if (!Save.data.game.persistance_keys.contains(SavePersistanceKey.GLOBAL_SEEN_INTRO))
		{
			Save.addGlobalPersistanceKey(SavePersistanceKey.GLOBAL_SEEN_INTRO);

			return IntroState;
		}

		#end

		#if SAPM_START_PLAYMENU
		return PlayMenuState;
		#end

		return TitleState;
	}
}
