package maki.sap_mingled.util.macros;

import haxe.macro.Context;
import haxe.macro.Expr.ExprOf;

class DefineMacro
{
	public static macro function defined(define:String):ExprOf<Bool>
	{
		return macro $v{Context.defined(define)};
	}

	public static macro function definedValue(define:String):ExprOf<String>
	{
		return macro $v{Context.definedValue(define)};
	}
}
