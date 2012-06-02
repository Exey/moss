package exey.moss.utils
{
	/**
	 * based on by.blooddy.core.utils.getCallerInfo
	 * CONFIG::debug is confifuration for conditional compilation in FlashDevelop
	 * @param	...rest
	 */
	public function stackTrace(...rest):void
	{
		CONFIG::debug {
			var stack:String = new Error().getStackTrace();
			//trace(stack);
			var match:Array =stack.match( /(?<=^\sat\s).+?(?=\(\))/gm )
			var instance:String = match[1];
			var callerInstance:String = match[2];
			var functionName:String;
			var callerClass:String = "";
			var className:String;
			//var lineNumber:String; // TODO
			if ( instance )
			{
				var result:Array = instance.match(/^(((.+?)::)?(.+?))?(\/(get\s|set\s)?((.+?)::)?(.+?))?$/);
				if ( result[9] )
					functionName = result[9];
				if ( result[4] && result[4] != "global" )
					className = result[4];
				if (result[3])
					if(callerInstance)
						callerClass = (callerInstance as String).split("::")[1];
					else
						callerClass = "null";
				//if ( result[10] )
					//lineNumber = result[10];
			}
			//rest.unshift(lineNumber+": "+className+"/"+functionName);
			var date:Date = new Date();
			var formatDate:Function = function(value:Number, digits:uint = 2):String
			{
				var s:String = value.toString();
				var result:String = "";
				while (result.length == digits - s.length - 1)
					result += "0";
				return result + s;
			}
			rest.unshift("4:[" + formatDate(date.getUTCHours()) + ":"
							 + formatDate(date.getUTCMinutes()) + ":"
							 + formatDate(date.getSeconds()) 	+ ":"
							 + formatDate(date.getMilliseconds(), 3)+"] "+callerClass+" -> "+className+"/"+functionName+"()");
			trace.apply(null, rest);
		}
	}
}