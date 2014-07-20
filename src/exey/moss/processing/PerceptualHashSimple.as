package exey.moss.processing 
{
	import flash.display.BitmapData;
	import exey.moss.utils.BitmapUtil;
	import exey.moss.utils.ImageProcessingUtil;
	
	/**
	 * ...
	 * @author Exey Panteleev
	 */
	public class PerceptualHashSimple 
	{
		
		static public const DELIMITER:String = "'"
		
		static public function convertFromFingerprintStringToBitmapData(fingerprint:String):BitmapData
		{
			var binaryStringTuple:Array = convertFromFingerprintStringToBinaryString(fingerprint)
			var lenX:int = binaryStringTuple[0]
			var lenY:int = binaryStringTuple[1]
			var bits:String = binaryStringTuple[2]
			var result:BitmapData = new BitmapData(lenX, lenY)
			var x:int, y:int, c:uint
			var i:Number = 0
			for (x = 0; x < lenX; x++) {
				for (y = 0; y < lenY; y++) {
					c = bits.charAt(i) == "1" ? 0x000000 : 0xFFFFFF
					result.setPixel(x, y, c)
					i++
				}
			}
			return result;
		}
		
		/**
		 * 
		 * @param	fingerprint
		 * @return [lenX, lenY, byteString]
		 */
		static public function convertFromFingerprintStringToBinaryString(fingerprint:String):Array
		{
			var split:Array = fingerprint.split(DELIMITER)
			var lenX:int = parseInt(split[0])
			var lenY:int = parseInt(split[1])
			var bits:String = split[2]			
			var byteArray:Vector.<uint> = Exey65.decode(bits, bits.length)
			//trace(byteArray.length, "|", byteArray)
			var byteString:String = toBinaryString(byteArray)
			//trace(byteString.length, "|", byteString)			
			return [lenX, lenY, byteString]
		}
		
		static public function convertBitmapDataToFingerprintString(bmd:BitmapData, bit:int = 6):String
		{
			var x:int, y:int, c:uint
			var lenX:int = bmd.width 
			var lenY:int = bmd.height
			//var s:String = ""
			var byteArray:Vector.<uint> = new <uint>[]
			var byteString:String = ""
			var byteInt:int
			var byteLength:int
			for (x = 0; x < lenX; x++) {
				for (y = 0; y < lenY; y++) {
					c = bmd.getPixel(x, y)
					if (byteLength == bit) {
						byteInt = parseInt(byteString, 2)
						//s += byteString
						byteString = ""
						byteLength = 0
						byteArray.push(byteInt)						
					} 					
					byteString += c == 0 ? "1" : "0"
					byteLength++
				}
			}
			//s+=byteString
			while (byteString.length == bit) {
				byteString += 0
			}
			byteArray.push(parseInt(byteString, 2));
			//trace(s.length, "|", s)
			//trace(byteArray.length, "|", byteArray)
			var result:String = lenX+DELIMITER+lenY+DELIMITER+Exey65.encode(byteArray)
			return result;
		}
		
		static public function convertBitmapDataToBinaryString(bmd:BitmapData, bit:int = 6):String
		{
			var x:int, y:int, c:uint
			var lenX:int = bmd.width 
			var lenY:int = bmd.height			
			var result:String = ""
			for (x = 0; x < lenX; x++) {
				for (y = 0; y < lenY; y++) {
					c = bmd.getPixel(x, y)					
					result += c == 0 ? "1" : "0"
				}
			}
			return result;
		}
		
		static public function createFingerprintBitmapData(bitmapData:BitmapData, longSide:Number = 16):BitmapData
		{
			var hihTuple:Array = Exey65.horizontalIntensityHistogram(bitmapData); 
			var bmd:BitmapData = ImageProcessingUtil.integralImageThresholding(BitmapUtil.resizeByLong(hihTuple[0], longSide));
			return bmd
		}
		
		static public function toBinaryString(v:Vector.<uint>, bit:int = 6):String
		{
			var result:String = ""
			var length:int = v.length
			var sn:String
			for (var i:int = 0; i < length; i++) {
				sn = uint(v[i]).toString(2)
				while (sn.length < bit)
					sn = "0" + sn
				result += sn
			}
			return result
		}
		
	}
}