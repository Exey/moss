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
			ExternalInterface.call( "console.log" , rest.join(" "));
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