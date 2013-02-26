package exey.moss.mngr.data
{
	/**
	 * ...
	 * @author Exey Panteleev
	 */
	public class AssetData
	{
		public var url:String;
		public var content:*;
		
		public function AssetData(url:String, content:*)
		{
			this.url = url;
			this.content = content;
		}
		
		public function toString():String
		{
			return "[AssetData url: " + url + "  content: " + content + "]";
		}
		
	}

}