package maki.sap_mingled.data.params;

typedef PlayMusicParams =
{
	> PlaySoundParam,

	var ?looped:Bool;

	var ?fade_out:Bool;
	var ?fade_out_duration:NullFloat;
}
