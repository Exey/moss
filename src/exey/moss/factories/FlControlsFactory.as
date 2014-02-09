package exey.moss.factories 
{
	import fl.controls.CheckBox;
	import fl.controls.ColorPicker;
	import fl.controls.ComboBox;
	import fl.controls.Slider;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	/**
	 * ...
	 * @author Exey Panteleev
	 */
	public class FlControlsFactory 
	{
		static public function comboBox(cont:DisplayObjectContainer, x:Number, y:Number, dataProvider:Array, changeHandler:Function, width:Number = 100, height:Number = 25):ComboBox 
		{
			var cb:ComboBox = new ComboBox();
			cb.move(x, y);
			for (var i:int = 0; i < dataProvider.length; i++) cb.addItem(dataProvider[i])
			cb.addEventListener(Event.CHANGE, changeHandler);
			cb.width = width;
			cb.height = height;
			cont.addChild(cb);
			return cb
		}
		
		static public function checkBox(cont:DisplayObjectContainer, x:Number, y:Number, text:String, changeHandler:Function, width:Number = 150, height:Number = 25):CheckBox 
		{
			var cb:CheckBox = new CheckBox();
			cb.move(x, y);
			cb.label = text;
			cb.addEventListener(Event.CHANGE, changeHandler);
			cb.width = width;
			cb.height = height;
			cont.addChild(cb);
			return cb
		}
		
		static public function slider(cont:DisplayObjectContainer, x:Number, y:Number, changeHandler:Function, width:Number = 100, height:Number = 25, minimum:Number = 0, maximum:Number = 100, step:int = 1):Slider 
		{
			var s:Slider = new Slider();
			s.move(x, y);
			s.addEventListener(Event.CHANGE, changeHandler);
			s.minimum = minimum;
			s.maximum = maximum;
			s.width = width;
			s.height = height;
			s.liveDragging = true;
			s.snapInterval = step;
			cont.addChild(s);
			return s
		}
		
		static public function colorPicker(cont:DisplayObjectContainer, x:Number, y:Number, changeHandler:Function, width:Number = 50, height:Number = 20):ColorPicker 
		{
			var cp:ColorPicker = new ColorPicker();
			cp.move(x, y)
			cp.addEventListener(Event.CHANGE, changeHandler);
			cp.width = width
			cp.height = height
			cont.addChild(cp)
			return cp
		}
		
	}
}