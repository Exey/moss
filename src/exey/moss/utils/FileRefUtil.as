package exey.moss.utils 
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.FileReference;
	import flash.utils.ByteArray;
	/**
	 * FileReference Util
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
		
		static public function browseForFile(completeHandler:Function, isText:Boolean = false):FileReference {
			var fr:FileReference = new FileReference();
			fr.addEventListener(Event.SELECT, select);
			fr.addEventListener(IOErrorEvent.IO_ERROR, error);
			fr.browse();
			return fr;
			function error(e:IOErrorEvent = null):void {
				trace("3:"+e, fr.data)
			}
			function select(e:Event = null):void {
				fr.removeEventListener(Event.SELECT, arguments.callee);
				fr.addEventListener(Event.COMPLETE, complete);
				fr.load();
			}
			function complete(e:Event = null):void {
				fr.removeEventListener(Event.COMPLETE, arguments.callee);
				if (isText) {
					completeHandler.apply(null, [fr.data]);
					return;
				}
				var l:Loader = new Loader();
				l.contentLoaderInfo.addEventListener(Event.COMPLETE, loader_complete);
				l.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, error);
				l.loadBytes(fr.data);
			}
			function loader_complete(e:Event = null):void {
				e.target.removeEventListener(Event.COMPLETE, arguments.callee);
				completeHandler.apply(null, [e.target.content]);
			}
		}
	}
}