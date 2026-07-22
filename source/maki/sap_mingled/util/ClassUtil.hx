package maki.sap_mingled.util;

class ClassUtil
{
	public static function getClass(_cls:Any):Class<Any> return (_cls is Class) ? _cls : Type.getClass(_cls ?? null);

	/**
	 * Only works with instanced classes (example: `new TitleState()`)
	 */
	public static function getMetadata(_cls:Any):Dynamic<Array<Dynamic>> return Meta.getType(getClass(_cls));

	/**
	 * Only works with instanced classes (example: `new DebugDisplay()`)
	 */
	public static function getFields(_cls:Any):Dynamic<Dynamic<Array<Dynamic>>> return Meta.getFields(getClass(_cls));

	/**
	 * Only works with instanced classes (example: `new Main()`)
	 */
	public static function getStatics(_cls:Any):Dynamic<Dynamic<Array<Dynamic>>> return Meta.getStatics(getClass(_cls));
}
