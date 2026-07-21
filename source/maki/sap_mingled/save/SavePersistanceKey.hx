package maki.sap_mingled.save;

enum abstract SavePersistanceKey(String) from String to String
{
	var GLOBAL_FIRST_TIME = 'GLOBAL_FIRST_TIME';
	var GLOBAL_SEEN_INTRO = 'GLOBAL_SEEN_INTRO';
}
