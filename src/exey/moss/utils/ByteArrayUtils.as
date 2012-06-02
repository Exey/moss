package exey.moss.utils 
{
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author 
	 */
	public class ByteArrayUtils
	{
		/** read bytes from embeded XML */
		static public function byteArrayToXML(byteArray:ByteArray):XML
		{
			return new XML( byteArray.readUTFBytes( byteArray.length ) );
		}
	}
}