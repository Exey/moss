package exey.moss.gui.comps.control {
	import exey.moss.gui.comps.button.GrowButton;
	import exey.moss.gui.comps.text.TextFieldLabel;
	import exey.moss.utils.AlignUtil;
	import exey.moss.utils.LoaderUtil;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author 
	 */
	public class SubButton extends GrowButton
	{
		static private const GROW_RATIO:Number = 1.1;
		private var _tf:TextField;
		private var _label:String;
		
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
			//skin = MovieClip(LoaderUtil.addTo(this, "SubButtonSkin"));
			skin = MovieClip(LoaderUtil.addTo(this, "SubButtonSkin"));
			_tf = new TextFieldLabel(this, 10, 0, new TextFormat( "Arial", 14, 0x000000, true ), _label);
			_tf.mouseEnabled = false;
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