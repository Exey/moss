package exey.moss.debug 
{
	import flash.external.ExternalInterface;
	/**
	 * Logging to JavaScript through ExternalInterface
	 * @author Exey Panteleev
	 */
	 
	public function jslog(...rest):void
	{
		var c:* = ExternalInterface.call("function(){if (window.console) return console.log}")
		if (ExternalInterface.available) {
			//ExternalInterface.call("function(){if (window.console && console.log) {console.log()}")
		}
	}
}
