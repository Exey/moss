package exey.moss.utils
{
	import flash.external.ExternalInterface;
	public class DebugUtils
	{
		static public function dump(obj:Object, showFunctions:Boolean = false, showUndefined:Boolean = false, showXMLstructures:Boolean = false, maxLineLength:int = 100, indent:int = 0):String
		{
			var du:DebugUtils = new DebugUtils();
			//if (maxLineLength == undefined)
			//{
			//   maxLineLength = 100;
			//}
			//if (indent == undefined) indent = 0;
			if (obj == null)
				return "null";
			return du.realToString(obj, showFunctions, showUndefined, showXMLstructures, maxLineLength, indent);
		}

		public function DebugUtils()
		{
			this.inProgress = new Array();
		}

		private var inProgress:Array;

		private function realToString(obj:Object, showFunctions:Boolean, showUndefined:Boolean, showXMLstructures:Boolean, maxLineLength:int, indent:int):String
		{
			for (var x:int = 0; x < this.inProgress.length; x++)
			{
			if (this.inProgress[x] == obj) return "***";
			}
			this.inProgress.push(obj);

			indent ++;
			var t:String = typeof(obj);
			//trace("<<<" + t + ">>>");
			var result:String;

			if ((obj is XML) && (showXMLstructures != true))
			{
			result = obj.toString();
			}
			else if (obj is Date)
			{
			result = obj.toString();
			}
			else if (t == "object")
			{
			var nameList:Array = new Array();
			if (obj is Array)
			{
			   result = "["; // "Array" + ":";
			   for (var i:int = 0; i < obj.length; i++)
			   {
				  nameList.push(i);
			   }
			}
			else
			{
			   result = "{"; // "Object" + ":";
			   for (var k:* in obj)
			   {
				  nameList.push(k);
			   }
			   nameList.sort();
			}

			//if (obj.length == undefined) trace("obj.length undefined");
			//if (obj.length == null) trace("obj.length null");
			//if (obj.length == 0) trace("obj.length 0");
			//trace("namelist length " + nameList.length + ", obj.length " + obj.length);
			var sep:String = "";
			for (var j:int = 0; j < nameList.length; j++)
			{
			   var val:* = obj[nameList[j]];

			   var show:Boolean = true;
			   if (typeof(val) == "function") show = (showFunctions == true);
			   if (typeof(val) == "undefined") show = (showUndefined == true);

			   if (show)
			   {
				  result += sep;
				  if (!(obj is Array))
					 result += nameList[j] + ": ";
				  result +=
					 realToString(val, showFunctions, showUndefined, showXMLstructures, maxLineLength, indent);
				  sep = ", `";
			   }
			}
			if (obj is Array)
			   result += "]";
			else
			   result += "}";
			}
			else if (t == "function")
			{
				result = "function";
			}
			else if (t == "string")
			{
				result = "\"" + obj + "\"";
			}
			else
			{
				result = String(obj);
			}

			if (result == "undefined") result = "-";
			this.inProgress.pop();
			return DebugUtils.replaceAll(result, "`", (result.length < maxLineLength) ? "" : ("\n" + doIndent(indent)));
		}

		static public function replaceAll (str:String, from:String, to:String):String
		{
			var chunks:Array = str.split(from);
			var result:String = "";
			var sep:String = "";
			for (var i:int = 0; i < chunks.length; i++)
			{
				result += sep + chunks[i];
				sep = to;
			}
			return result;
		}

		private function doIndent(indent:int):String
		{
			var result:String = "";
			for (var i:int = 0; i < indent; i ++)
			{
				result += "     ";
			}
			return result;
		}
		
		/**
		* Dumper обьектов
		*/
		static public function dumper(node:Object, fl:int = 2, name:String = '', tabs:String = ''):String {
			var attr:Vector.<String> = Vector.<String>([]);
			var i:int;	//	итерации
			var debStr:String = '';
			debStr += (name ? '\n' + tabs + '"'+ name + '": ' : '');

			var tp:String = typeof(node);
			////trace('typeof: ', tp, 'name: ', name, 'tabs: ', tabs.length);
			switch(tp) {
				case 'string':		// строка
					debStr += '"'+node+'"';
					break;
				case 'number':		// число
					debStr += node;
					break;
				case 'function':	// функция
				case 'object':		// обьект
					if(node == null) {
						debStr += 'null';
						break;
					}
					////trace('hhhhh: ', node.constructor,':', node.prototype);
					var constrType:String = node.constructor.toString();
					if(constrType == '[class Array]') {			// массив
						debStr += "["+ '\n' + tabs + '\t';
						for(i=0;i< node.length;i++) attr.push(dumper(node[i], fl, '', tabs+'\t'));
						////trace('attr: ',name , ' : ', attr);
						debStr += attr.join(',');
						debStr += '\n' + tabs + ']';
					} else if(constrType == '[class Object]') {	// хэш
						debStr += "{" + tabs + '\t';
						for(var prop:String in node) attr.push(dumper(node[prop], fl, prop, tabs+'\t'));
						debStr += tabs+'\t' + attr.join(',');
						debStr += '\n' + tabs + '}';
					} else  {									// напечатаем класс
						debStr += constrType;
					}
					break;
			}
			return debStr;
		}
	}
}