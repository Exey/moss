package exey.moss.utils 
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.FileReference;
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author Exey Panteleev
	 */
	public class FileRefUtil 
	{
		
		static public function getFileName(path:String, withExtension:Boolean = false):String {
			var name:String;
			var pathSplit:Array = path.split("/");
			name = pathSplit[pathSplit.length - 1];
			if (!withExtension)
				name = name.split(".")[0]
			return name;
		}
		
		static public function saveBytes(ba:ByteArray, fileName:String = ""):void {
			var saveFileRef:FileReference = new FileReference();
			saveFileRef.save(ba, fileName);
		}
		
		static public function browseForFile(completeHandler:Function):void {
			var fr:FileReference = new FileReference();
			fr.addEventListener(Event.SELECT, select);
			fr.browse();
			function select(e:Event = null):void {
				fr.removeEventListener(Event.SELECT, arguments.callee);
				fr.addEventListener(Event.COMPLETE, complete);
				fr.load();
			}
			function complete(e:Event = null):void {
				fr.removeEventListener(Event.COMPLETE, arguments.callee);
				var l:Loader = new Loader();
				l.contentLoaderInfo.addEventListener(Event.COMPLETE, loader_complete);
				l.loadBytes(fr.data);
			}
			function loader_complete(e:Event = null):void {
				e.target.removeEventListener(Event.COMPLETE, arguments.callee);
				completeHandler.apply(null, [e.target.content]);
			}
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