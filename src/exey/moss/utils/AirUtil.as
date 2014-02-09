package exey.moss.utils 
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	/**
	 * Air File Util
	 * @author Exey Panteleev
	 */
	public class AirUtil 
	{
		
		static public function savePNG(bytes:ByteArray, file:File):void 
		{
			var fs:FileStream = new FileStream();
			fs.open(file, FileMode.WRITE);
			fs.writeBytes(bytes);
			fs.close();
		}
		
		static public function readBinary(f:File, handler:Function):void 
		{
			var fs:FileStream=new FileStream();
			var ba:ByteArray=new ByteArray();
			fs.open(f, FileMode.READ);
			fs.readBytes(ba);
			fs.close();
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, function(e:Event = null):void {
				trace("3:CAN'T READ FILE AS BINARY", f.url)
			})
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, handler);
			loader.loadBytes(ba);
		}
		
	}
}