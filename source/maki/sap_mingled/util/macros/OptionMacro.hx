package maki.sap_mingled.util.macros;

import haxe.macro.Expr.ExprOf;
import sys.FileSystem;
import sys.io.File;

class OptionMacro
{
	public static macro function buildArray(field:String):ExprOf<Array<String>>
	{
		var lines:Array<String> = [];
		final path = 'dev/macros/options/$field.txt';

		if (FileSystem.exists(path))
		{
			var file = File.getContent(path);

			if (file != null) lines = [for (line in file.split('\n')) if (line.trim().length > 0) line.trim()];
		}

		trace('Array Option : $field=$lines');

		return macro $v{lines};
	}
}
