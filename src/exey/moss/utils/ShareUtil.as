package exey.moss.utils 
{
	import flash.net.navigateToURL;
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
				vars.s = 100;
				//vars.t = encodeURI(text);
				//vars.src = "sp";
				//share("http://www.facebook.com/sharer.php?", vars);
				share("http://www.facebook.com/sharer.php?p[url]="+encodeURIComponent(url)+"&p[summary]="+encodeURIComponent(text), vars);
				//var param:String = url+vars.toString();
				//var js:String = "share('"+param+"');";
				//trace(js);
				//navigateToURL(new URLRequest(param), "_blank")
			}
			
			/**
			 * https://www.facebook.com/dialog/feed?app_id="+projectApId+"&link="+messageUrl+"&picture="+projectThumb+"&name="+messageName+"&description="+messageDescription+"&redirect_uri="+redirectUrl;
			 * @param	appId Facebook App ID
			 * @param	title Title for the message
			 * @param	link Link to the application
			 * @param	description Whatever you'd like to say
			 * @param	picture Application Thumbnail
			 * @param	redirectUri Once a user shares the link, where to redirect them - for me this is facebook again so they can log out
			 */
			static public function facebookOpenGraph(appId:String, title:String, link:String, description:String, picture:String, redirectUri:String):void 
			{
				var vars:URLVariables = new URLVariables();
				vars.app_id = appId;
				vars.link = link;
				vars.picture = picture;
				vars.name = title;
				vars.description = description;
				vars.redirect_uri = redirectUri;
				share("https://www.facebook.com/dialog/feed?", vars);
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
			
			static private function share(url:String, vars:URLVariables):void 
			{
				var param:String = url+vars.toString();
				//var js:String = "share('"+param+"');";
				//trace(js);
				navigateToURL(new URLRequest(param), "_blank")
				 //ExternalInterface.call(js); // TODO create popup with JS			
			}
		
	}
}