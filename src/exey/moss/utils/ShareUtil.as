package exey.moss.utils 
{
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	/**
	 * ...
	 * @author Exey Panteleev
	 */
	public class ShareUtil 
	{
			/** http://www.facebook.com/sharer.php?u={{ share_url | url_encode() }}&amp;t={{ title | url_encode() }}&amp;src=sp" */
			static public function facebook(url:String, text:String):void
			{				
				var vars:URLVariables = new URLVariables();
				vars.u = url;
				vars.t = text;
				vars.src = "sp";
				share("http://www.facebook.com/sharer.php?", vars);
			}
			
			/** http://vkontakte.ru/share.php?url={{ share_url | url_encode() }}" */
			static public function vk(url:String):void
			{
				var vars:URLVariables = new URLVariables();
				vars.url = url;
				share("http://vkontakte.ru/share.php?", vars);
			}
			
			/** http://www.odnoklassniki.ru/dk?st.cmd=addShare&amp;st._surl={{ share_url | url_encode() }}&amp;title={{ title | url_encode() }}" */
			static public function odnoklassniki(url:String, title:String):void
			{
				var vars:URLVariables = new URLVariables();
				vars["st._surl"] = url;
				vars.title = title;
				share("http://www.odnoklassniki.ru/dk?st.cmd=addShare&", vars);
			}			
			
			/** http://twitter.com/share?url={{ share_url | url_encode() }}&amp;text={{ title | url_encode() }}"*/
			static public function twitter(url:String, text:String):void
			{
				var vars:URLVariables = new URLVariables();
				vars.url = url;
				vars.text = text;
				vars.src = "sp";
				share("http://twitter.com/share?", vars);
			}
			
			/** http://connect.mail.ru/share?url={{ share_url | url_encode() }}&amp;title={{ title | url_encode() }}&amp;description={{ description | url_encode() }}&amp;imageurl={{ imageurl | url_encode()  }}" */
			static public function moiMirMailRu(url:String, title:String, description:String, imageurl:String = ""):void
			{
				var vars:URLVariables = new URLVariables();
				vars.url = url;
				vars.title = title;
				vars.description = description;
				vars.imageurl = imageurl;
				vars.src = "sp";
				share("http://connect.mail.ru/share?", vars);
			}			
			
			/** https://plus.google.com/share?url={{ share_url | url_encode() }}"  */
			static public function googlePlus(url:String):void 
			{
				var vars:URLVariables = new URLVariables();
				vars.url = url;
				share("https://plus.google.com/share?", vars);
			}
			
			private function share(url:String, vars:URLVariables):void 
			{
				var param:String = url+vars.toString();
				//var js:String = "share('"+param+"');";
				//trace(js);
				navigateToURL(new URLRequest(param), "_blank")
				 //ExternalInterface.call(js); // TODO create popup with JS			
			}
		
	}
}