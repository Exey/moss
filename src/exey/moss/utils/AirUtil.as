package exey.moss.utils 
{
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	/**
	 * ...
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
		
	}

}