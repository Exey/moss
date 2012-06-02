package exey.moss.mngr.data
{
	/**
	 * ...
	 * @author Exey Panteleev
	 */
	public class ResourceData
	{
		public var url:String;
		public var content:*;
		
		public function ResourceData(url:String, content:*)
		{
			this.url = url;
			this.content = content;
		}
		
		public function toString():String
		{
			return "[ResourceData url: " + url + "  content: " + content + "]";
		}
		
	}

}