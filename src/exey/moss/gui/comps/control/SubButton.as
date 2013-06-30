package exey.moss.gui.comps.control {
	import exey.moss.factories.GuiFactory;
	import exey.moss.gui.comps.button.GrowButton;
	import exey.moss.gui.comps.text.TextFieldLabel;
	import exey.moss.utils.AlignUtil;
	import exey.moss.utils.DrawUtil;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author Exey Panteleev
	 */
	public class SubButton extends GrowButton
	{
		static private const GROW_RATIO:Number = 1.1;
		private var _tf:TextField;
		private var _label:String;
		public function get text():String {return _tf.text}
		
		override public function set selected(value:Boolean):void 
		{	
			_selected = value;
			if (_selected) 
			{
				growUp();
				skin.filters = [new GlowFilter(0xFFFFFF)];
				_tf.textColor = 0xFFFFFF;
			}
			else
			{
				growDown();
				skin.filters = [];
				_tf.textColor = 0x000000;
			}
			
		}		
		
		public function get label():String { return _label; }
		
		public function SubButton(parent:DisplayObjectContainer, xpos:Number, ypos:Number, handler:Function, text:String, scaleRatio:Number = 1) 
		{
			super(parent, xpos, ypos, handler, GROW_RATIO);
			_label = text;
			initialize(scaleRatio);
		}
		
		private function initialize(scaleRatio:Number):void
		{
			// draw bg
			//skin = GuiFactory.glassyButton(50, 20, 6, 0xE4DF23, 0.8);
			skin = new Sprite();
			_tf = new TextFieldLabel(this, 10, 0, new TextFormat( "Arial", 14, 0x000000, true ), _label);
			_tf.mouseEnabled = false;
			var skinWidth:Number = _tf.textWidth + 20;
			var skinHeight:Number = _tf.textHeight + 8;
			skin.x = skinWidth * 0.5; 
			skin.y = skinHeight * 0.5;
			DrawUtil.rect((skin as Sprite).graphics, -skinWidth*0.5, -skinHeight*0.5, skinWidth, skinHeight, 0xEED186);
			AlignUtil.toHorizontalCenter(_tf, skin as DisplayObjectContainer);
		}
		
		public function autoWidth(horizontalPadding:Number = 5):void
		{
			skin.width = _tf.width + horizontalPadding * 2;
			AlignUtil.toHorizontalCenter(_tf, skin as DisplayObjectContainer);
		}
		
		public function unhighlight():void 
		{
			this.selected = false;
		}		
		
		public function highlight():void 
		{
			this.selected = true;
		}
		
	}
}