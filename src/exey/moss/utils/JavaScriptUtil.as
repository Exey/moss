package exey.moss.utils 
{
	import flash.external.ExternalInterface;
	/**
	 * ...
	 * @author Exey Panteleev
	 */
	public class JavaScriptUtil 
	{
		
		static public function consoleLog(...rest):void 
		{
			if(ExternalInterface.available)
				ExternalInterface.call( "console.log" , rest.join(" "));
			else trace("3: CAN'T LOG NO ExternalInterface")
		}
		
		static public function getCookie():*
		{
			return ExternalInterface.call("document.cookie");
		}
		
		static public function getPageURL():*
		{
			return ExternalInterface.call("window.location.href.toString");
		}
		
		static public function getUserAgent():* 
		{
			return ExternalInterface.call("window.navigator.userAgent.toString");			
		}
		
		static public function getPlatform():* 
		{
			return ExternalInterface.call("window.navigator.platform.toString");
		}
		
		
	}
}