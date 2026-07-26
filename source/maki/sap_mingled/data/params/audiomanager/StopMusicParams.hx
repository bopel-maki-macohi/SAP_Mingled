package maki.sap_mingled.data.params.audiomanager;

typedef StopMusicParams =
{
	var ?fade_out:Bool;
	var ?fade_out_duration:NullFloat;
	var ?fade_out_on_complete:FuncVoid;
}
