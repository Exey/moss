package exey.moss.gui.comps.control {
	import flash.display.DisplayObjectContainer;
	import exey.moss.gui.abstract.ComponentAbstract;
	
	/**
	 * ...
	 * @author Exey Panteleev
	 */
	public class HMenu extends ComponentAbstract {
		
		private var _buttons:Array;
		public function get buttons():Array { return _buttons; }
		private var _gap:Number;
		
		public function HMenu(parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number = 0, gap:Number = 5)
		{
			_gap = gap;
			super(parent, xpos, ypos);
		}
		
		public function initialize(labels:Array, handlers:Array):void
		{
			if (labels.length != handlers.length)
				throw(new Error("Number of labels not equal to handlers"))
			_buttons = [];
			var shiftX:Number = 0;
			//var button:MicroButton;
			var button:SubButton;
			for (var i:int = 0; i < labels.length; i++) {
				//button = new MicroButton(this, shiftX, 0, 0xCCCCCC, labels[i], 90, 30, handlers[i])
				button = new SubButton(this, shiftX, 0, handlers[i], labels[i]);
				button.autoWidth()
				_buttons.push(button)
				shiftX += button.width + _gap;
			}
		}
		
		public function unhighlightAll():void
		{
			for (var i:int = 0; i < _buttons.length; i++) {
				SubButton(_buttons[i]).unhighlight();
			}
		}
		
		public function destroy():void
		{
			hide();
			for (var i:int = 0; i < _buttons.length; i++) {
				_buttons[i].destroy();
			}
			_buttons = null;
		}
		
		public function getButtonByLabel(label:String):SubButton 
		{
			for (var i:int = 0; i < _buttons.length; i++) 
			{
				if(SubButton(_buttons[i]).label == label)
					return _buttons[i];
			}
			return null;
		}
		
	}
}