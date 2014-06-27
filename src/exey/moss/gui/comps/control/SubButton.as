package exey.moss.gui.comps.control {
	import exey.moss.gui.comps.button.GrowButton;
	import exey.moss.gui.comps.text.TextFieldLabel;
	import exey.moss.utils.AlignUtil;
	import exey.moss.utils.DrawUtil;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author Exey Panteleev
	 */
	public class SubButton extends GrowButton
	{
		//--------------------------------------------------------------------------
		//
		//  Static
		//
		//--------------------------------------------------------------------------
		
		static private const GROW_RATIO:Number = 1.1;
		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		private var _tf:TextField;
		
		public function get text():String { return _tf.text }
		public function set text(value:String):void {
			_tf.text = value;
		}
		
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
				_tf.textColor = textFormat.color as uint;
			}
		}
		
		protected var _togglable:Boolean
		public function get togglable():Boolean { return _togglable; }
		public function set togglable(value:Boolean):void {_togglable = value;}
		
		//private var _label:String;
		//public function get label():String { return _label; }
		
		//--------------------------------------------------------------------------
		//
		//  Private Vars
		//
		//--------------------------------------------------------------------------
		
		private var textFormat:TextFormat;
		private var backgroundColor:uint;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		public function SubButton(parent:DisplayObjectContainer, xpos:Number, ypos:Number, handler:Function, text:String, scaleRatio:Number = 1, textFormat:TextFormat = null, backgroundColor:uint = 0xEED186, backgroundAlpha:Number = 1, widthPadding:Number = 20, heightPadding:Number = 8) 
		{
			super(parent, xpos, ypos, handler, GROW_RATIO);
			this.backgroundColor = backgroundColor;
			if (!textFormat) this.textFormat = new TextFormat( "Arial", 14, 0x000000, true );
			else this.textFormat = textFormat;
			initialize(scaleRatio, backgroundAlpha, widthPadding, heightPadding, text);
		}
		
		//--------------------------------------------------------------------------
		//
		//  API
		//
		//--------------------------------------------------------------------------
		
		override public function addHandler(handler:Function):void {
			//super.addHandler(handler);
			this.handler = handler;
			if (handler != null) 
				this.addEventListener(MouseEvent.CLICK, function(e:Event):void {
					if (_togglable)
						selected = !_selected; 
					handler.apply(null, [e]);
				});
		}
		
		private function initialize(scaleRatio:Number, backgroundAlpha:Number, widthPadding:Number, heightPadding:Number, text:String):void
		{
			// draw bg
			//skin = GuiFactory.glassyButton(50, 20, 6, 0xE4DF23, 0.8);
			skin = new Sprite();
			_tf = new TextFieldLabel(this, 10, 0, textFormat, text);
			_tf.mouseEnabled = false;
			var skinWidth:Number = _tf.textWidth + widthPadding;
			var skinHeight:Number = _tf.textHeight + heightPadding;
			skin.x = skinWidth * 0.5; 
			skin.y = skinHeight * 0.5;
			DrawUtil.rect((skin as Sprite).graphics, -skinWidth*0.5, -skinHeight*0.5, skinWidth, skinHeight, backgroundColor, backgroundAlpha);
			AlignUtil.toHorizontalCenter(_tf, skin as DisplayObjectContainer);
		}
		
		public function autoWidth(horizontalPadding:Number = 5):void
		{
			skin.width = _tf.width + horizontalPadding * 2;
			skin.x = skin.width * 0.5; 
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