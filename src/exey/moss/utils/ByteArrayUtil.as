package exey.moss.utils 
{
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	/**
	 * ...
	 * @author 
	 */
	public class ByteArrayUtil
	{
		/** read bytes from embeded XML */
		static public function byteArrayToXML(byteArray:ByteArray):XML
		{
			return new XML( byteArray.readUTFBytes( byteArray.length ) );
		}
		
		static public function bytesToStringWithPosition(ba:ByteArray, valuesPerString:uint = 1):String
		{
			var result:String = "";
			var originPosition:uint = ba.position;
			ba.position = 0
			var s:String
			var posLength:uint = String(ba.bytesAvailable).length+3;
			var sLength:uint = posLength + 5;
			while (ba.bytesAvailable) {				
				s = "[" + ba.position + "] ";
				while (posLength > s.length) s += " ";
				s += ba.readByte().toString(10);
				while (sLength > s.length) s += " ";
				result += s;
				if ((ba.position) % valuesPerString == 0)
					result += "\n";
			}
			ba.position = originPosition;
			return result;
		}
		
		static public function readDoubleFromPosition(ba:ByteArray, position:uint, endian:String):Number 
		{
			var ba2:ByteArray = new ByteArray();
			ba2.endian = endian
			ba.position = position;
			ba2.writeByte(ba.readByte())
			ba2.writeByte(ba.readByte())
			ba2.writeByte(ba.readByte())
			ba2.writeByte(ba.readByte())
			ba2.writeByte(ba.readByte())
			ba2.writeByte(ba.readByte())
			ba2.writeByte(ba.readByte())
			ba2.writeByte(ba.readByte())
			ba2.position = 0;
			return ba2.readDouble();
		}
		
		static public function readIntFromPositon(ba:ByteArray, position:uint, endian:String):int 
		{
			var ba2:ByteArray = new ByteArray();
			ba2.endian = endian
			ba.position = position;
			ba2.writeByte(ba.readByte())
			ba2.writeByte(ba.readByte())
			ba2.writeByte(ba.readByte())
			ba2.writeByte(ba.readByte())
			ba2.position = 0;
			return ba2.readInt();
		}		
		
		static public function toArray(ba:ByteArray):Array
		{
			var originPosition:uint = ba.position;
			ba.position = 0
			var result:Array = [];
			while (ba.bytesAvailable)
				result.push(ba.readByte());
			ba.position = originPosition;
			return result;
		}
	}
}