package exey.moss.gui.comps.button 
{
	import exey.moss.gui.abstract.ComponentAbstract;
	import exey.moss.gui.comps.text.TextFieldLabel;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextFormat;
	import org.osflash.signals.Signal;
	
	/**
	 * RadioButton
	 * @author Exey Panteleev
	 */
	public class RadioButton extends ComponentAbstract
	{		
		private var textFormat:TextFormat;
		protected const DEFAULT_RADIUS:Number = 9;
		protected const BORDER_THICKNESS:Number = 1;
		protected const BORDER_COLOR:uint = 0x000000;
		protected const BACKGROUND_COLOR:uint = 0xFFFFFF;
		protected const DOT_COLOR:uint = 0x454545;
		
		protected var _scale:Number;
		override public function set scale(value:Number):void { _scale = value; }
		public function get scale():Number { return _scale; }
		
		protected var _selected:Boolean;
		public function get selected():Boolean { return _selected; }
		public function set selected(value:Boolean):void  {
			_selected = value;
			if (_selected)
				dot.visible = true;
			else
				dot.visible = false;
		}
		
		public var textLabel:TextFieldLabel;
		protected var dot:Sprite;
		
		public var selectSignal:Signal;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------		
		public function RadioButton(parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number = 0, label:String = "", scale:Number = 1, textFormat:TextFormat = null) 
		{
			_scale = scale;
			if (!textFormat) this.textFormat = new TextFormat( "Arial", 18, 0x000000, "bold" );
			else this.textFormat = textFormat;
			super(parent, xpos, ypos);
			this.buttonMode = true
			draw();
			
			if (label != "") addLabel(label);
			selectSignal = new Signal();
			selected = false;
			this.addEventListener(MouseEvent.CLICK, onClick);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Event handlers
		//
		//--------------------------------------------------------------------------			
		
		protected function addLabel(label:String, color:uint = uint.MAX_VALUE):void 
		{
			if(color < uint.MAX_VALUE) textFormat.color = color 
			textLabel = new TextFieldLabel(this, 24+4, -2, textFormat, label, false);
		}		
		
		protected function onClick(e:MouseEvent):void
		{
			if (selected) selected = false;
			else selected = true;
			selectSignal.dispatch();
		}
		
		override public function draw():void
		{
			var radius:Number = DEFAULT_RADIUS*scale;
			this.graphics.lineStyle(BORDER_THICKNESS*scale, BORDER_COLOR);
			this.graphics.beginFill(BACKGROUND_COLOR);
			this.graphics.drawCircle(radius, radius, radius);
			
			dot = new Sprite();
			dot.graphics.beginFill(DOT_COLOR);
			dot.graphics.drawCircle(radius-4*scale, radius-4*scale, radius-4*scale);
			dot.x = 4 * scale;
			dot.y = 4 * scale;
			addChild(dot);
		}
		
	}
}