package exey.moss.utils 
{
	import exey.moss.debug.deb;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.geom.Rectangle;
	import flash.media.Sound;
	import flash.utils.ByteArray;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	/**
	 * ...
	 * @author Exey Panteleev
	 */
	public class SoundUtil 
	{
		
		static public function drawWaveformToGraphics(graphics:Graphics, sound:Sound, color:uint = 0xFFFFFF, width:int = 1024, heightMax:int = 150, depthPerPixel:int = 5, sampleRate:Number = 44.1, onComplete:Function = null, realTimeDraw:Boolean = false):Graphics 
		{
			var resolution:int = width * depthPerPixel;
			var soundBytes:ByteArray = new ByteArray();
			//var values:Vector.<uint> = new Vector.<uint>(width); // data
			var values:Vector.<uint> = new Vector.<uint>(); // data
			//var valueString:String = ""; // data
			var i:int = 0
			if (realTimeDraw) drawByTimeout();
			else for (i = 0; i < resolution; i++) drawStep();
			// by timeout
			var timeoutId:uint;
			function drawByTimeout():void {
				//deb(i, resolution);
				clearTimeout(timeoutId);
				for (i; i < resolution; i++) {
					drawStep();
					if (i % depthPerPixel == 0) {
						i++
						if(i < resolution)
							timeoutId = setTimeout(drawByTimeout, 0.0001);
						break;
					}
				}
				if (i == resolution) {
					if (onComplete != null)
						onComplete.apply(null, [values]);
					//trace(values);
					//trace(valueString);
				}
			}
			// draw
			function drawStep():void {
				sound.extract(soundBytes, 1, Math.floor((sound.length*sampleRate)*(i/resolution)));
				soundBytes.position = 0;
				while (soundBytes.bytesAvailable > 0) {
					var tmpNum:Number = new Number();
					tmpNum += soundBytes.readFloat();
				}
				drawLine(i, tmpNum);
				//var eol:String = i % 32 == 0 ? "\n" : ", ";
				//valueString += int(64*(Math.abs(tmpNum)))+eol
				values.push(Math.round(64 * (Math.abs(tmpNum))));
				//trace(values)
				soundBytes.clear();
			}
			function drawLine(i:Number, amp:Number):void {
				var pixX:Number = new Number(Math.floor(i/depthPerPixel));
				var pixY:Number = new Number((amp*heightMax)*0.5);
				graphics.lineStyle(1, color, (1.2/depthPerPixel), true);
				graphics.moveTo(pixX, ((heightMax*0.5)-pixY));
				graphics.lineTo(pixX, ((heightMax*0.5)+pixY));
			}				
			return graphics;
		}
		
		static public function toByteArray(sound:Sound, sampleRate:Number = 44.1):ByteArray 
		{
			var bytes:ByteArray = new ByteArray ();
			//sound.extract (bytes, int (sound.length * sampleRate));
			return bytes;
		}
		
		static public function soundToSpectrumBitmapData(sound:ByteArray, pixelsInSecond:Number=10, height:Number=100, sampleRate:uint=44100, backgroundColor:uint = 0x000000, color:uint = 0xFFFFFF):BitmapData
		{
			var step:uint = Math.round(sampleRate*8/pixelsInSecond)-8;
			do step-- while ( step % 8 );
			var width:uint = sound.length / step;
			if (width < 1) width = 1;
			var bmd:BitmapData = new BitmapData( width, height, false, backgroundColor);			
			height *= 0.5;			
			var leftChannel:Number, rightChannel:Number, mono:Number;
			var rect:Rectangle
			var i:uint = 0;
			while(sound.bytesAvailable) {
				leftChannel = sound.readFloat();
				rightChannel = sound.readFloat();
				mono = Math.sqrt(leftChannel*leftChannel + rightChannel*rightChannel)*0.5;				
				mono*=height;				
				rect = new Rectangle(i, height - mono, 1, mono * 2);				
				bmd.fillRect(rect, color);				
				sound.position = i*step;
				i++;
			}
			return bmd;
		}
		
	}
}