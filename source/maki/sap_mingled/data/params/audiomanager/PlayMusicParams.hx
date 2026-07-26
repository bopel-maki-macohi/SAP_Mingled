package maki.sap_mingled.data.params.audiomanager;

typedef PlayMusicParams =
{
	> PlaySoundParams,
	> StopMusicParams,

	var ?looped:Bool;
}
