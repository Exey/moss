package exey.moss.utils 
{
	import flash.display.Loader;
	import flash.events.Event;
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
			return name
		}
		
		static public function saveBytes(ba:ByteArray, fileName:String = null):void {
			var saveFileRef:FileReference = new FileReference();
			saveFileRef.save(ba);
		}
		
		static public function browseForFile(completeHandler:Function):void {
			var fr:FileReference = new FileReference();
			fr.addEventListener(Event.SELECT, select);
			fr.browse();
			function select(e:Event):void {
				fr.removeEventListener(Event.SELECT, arguments.callee);
				fr.addEventListener(Event.COMPLETE, complete);
				fr.load();				
			}
			function complete(e:Event):void {
				fr.removeEventListener(Event.COMPLETE, arguments.callee);
				var l:Loader = new Loader();
				l.contentLoaderInfo.addEventListener(Event.COMPLETE, loader_complete);
				l.loadBytes(fr.data);
			}
			function loader_complete(e:Event):void {
				e.target.removeEventListener(Event.COMPLETE, arguments.callee);
				completeHandler.apply(null, [e.target.content]);
			}
		}
	}

}