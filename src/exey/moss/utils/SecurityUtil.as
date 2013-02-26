package exey.moss.utils 
{
	import flash.system.Security;
	/**
	 * ...
	 * @author Exey Panteleev
	 */
	public class SecurityUtil 
	{
		
		static public function allowAll(allowedDomains:Array = null):void
		{
			//if (!allowedDomains) allowedDomains:Array = ['*'];
			Security.allowDomain("*")
			//for each(var i:String in allowedDomains)  {
				//Security.allowDomain(i);
				//Security.allowInsecureDomain(i);
			//}
		}
		
	}
}