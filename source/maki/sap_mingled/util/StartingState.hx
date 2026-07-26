package maki.sap_mingled.util;

import flixel.util.typeLimit.NextState.InitialState;

class StartingState
{
	public static function get():InitialState
	{
		if (DefineMacro.defined('SAPM_START_INTRO')) return getIntroState();

		if (DefineMacro.defined('SAPM_START_PLAYMENU')) return PlayMenuState;
		if (DefineMacro.defined('SAPM_START_OPTIONSMENU')) return OptionsMenuState;
		if (DefineMacro.defined('SAPM_START_CONTROLSMENU')) return ControlsMenuState;
		
		if (DefineMacro.defined('SAPM_START_LEVEL1')) return Level1;
		if (DefineMacro.defined('SAPM_START_LEVEL2')) return Level2;

		return TitleState;
	}

	public static function getIntroState():InitialState
	{
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

		return null;
	}
}
