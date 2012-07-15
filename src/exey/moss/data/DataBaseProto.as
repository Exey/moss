package exey.moss.data 
{
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author Exey Panteleev
	 */
	public class DataBaseProto 
	{
		
		public function DataBaseProto() 
		{
			
		}
		
		protected function parseJsonFromByteArray(b:ByteArray):Object 
		{
			var content:String = b.readUTFBytes(b.length);
			var result:Object = JSON.parse(content);
			return result
		}	
		
	}

}