package maki.sap_mingled.data.params.audiomanager;

typedef PlaySoundParams =
{
	var path:String;

	var ?fade_in:Bool;
	var ?fade_in_duration:NullFloat;

	var ?on_start:FuncVoid;
	var ?on_complete:FuncVoid;
}
