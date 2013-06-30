package exey.moss.debug
{
	import exey.moss.utils.TimeUtil;
	import flash.system.Capabilities;
	/**
	 * deb based on by.blooddy.core.utils.getCallerInfo
	 * CONFIG::debug is confifuration for conditional compilation
	 * @param	...rest
	 */
	public function deb(...rest):void
	{
		CONFIG::debug {
			if (!Capabilities.isDebugger) return;
			var stack:String = new Error().getStackTrace();
			var match:Array = stack.match(/(?<=^\sat\s).+?(?=\(\))/gm);
			var matchLineNumbers:Array = stack.match(/(?<=.as:|.mxml:).+?(?=\])/gm);
			var instance:String = match[1];
			var callerInstance:String = match[2];
			var functionName:String, callerName:String = "", className:String;
			if ( instance ) {
				var result:Array = instance.match(/^(((.+?)::)?(.+?))?(\/(get\s|set\s)?((.+?)::)?(.+?))?$/);
				if (result[9]) functionName = result[9];
				if (result[4] && result[4] != "global") className = result[4];
				if (result[3])
					if(callerInstance) callerName = matchLineNumbers[2]+":"+(callerInstance as String).split("::")[1];
					else callerName = "null";
			}
			var date:Date = new Date();
			rest.unshift("4:[" + date.toTimeString().split(" ")[0] +"."+TimeUtil.formatDate(date.getMilliseconds(), 3)+" "
							   + callerName+" -> "+matchLineNumbers[1]+":"+className+"/"+functionName+"()"+"] ");
			trace.apply(null, rest);
		}
	}
}