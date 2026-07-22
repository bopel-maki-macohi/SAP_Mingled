package maki.sap_mingled.util;

class ClassUtil
{
	public static function getMetadata(_cls:Any):Dynamic<Array<Dynamic>>
	{
		final cls = Type.getClass(_cls ?? null);
		final clsMeta = Meta.getType(cls);

		return clsMeta;
	}

	public static function getFields(_cls:Any):Dynamic<Dynamic<Array<Dynamic>>>
	{
		final cls = Type.getClass(_cls ?? null);
		final clsFields = Meta.getFields(cls);

		return clsFields;
	}

	public static function getStatics(_cls:Any):Dynamic<Dynamic<Array<Dynamic>>>
	{
		final cls = Type.getClass(_cls ?? null);
		final clsFields = Meta.getStatics(cls);

		return clsFields;
	}
}
