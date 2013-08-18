package exey.moss.gui.comps.button 
{
	import exey.moss.utils.EventUtil;
	import exey.moss.utils.LoaderUtil;
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	
	/**
	 * Button that grows on hower
	 * @author Exey Panteleev
	 */
	public class GrowButton extends EmptyButton 
	{
		protected var growRatio:Number;
		
		protected var _selected:Boolean;		
		public function get selected():Boolean { return selected; }		
		public function set selected(value:Boolean):void {
			_selected = value;
			if (_selected) this.skin.filters = [new GlowFilter()];
			else this.skin.filters = [];
		}
		
		override public function set enabled(value:Boolean):void {
			super.enabled = value;
			EventUtil.onNextFrame(this, function():void {
				if (!_enabled) growDown();
			})
		}
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		public function GrowButton(parent:DisplayObjectContainer, xpos:Number, ypos:Number, handler:Function, growRatio:Number = 1.1) 
		{
			super(parent, xpos, ypos, handler);
			this.growRatio = growRatio;
			this.addEventListener(MouseEvent.ROLL_OVER, handler_rollOver);
			this.addEventListener(MouseEvent.ROLL_OUT, handler_rollOut);
		}
		
		protected function growDown():void 
		{
			if (!skin) return;
			skin.scaleX = skin.scaleY = 1;
		}
		
		protected function growUp():void 
		{
			if (!skin) return;
			skin.scaleY = skin.scaleX = growRatio;
		}
		
		//--------------------------------------------------------------------------
		//
		//  API
		//
		//--------------------------------------------------------------------------			
		
		public function addMovieClip(string:String):void 
		{
			this.skin = LoaderUtil.getFromCurrentDomain(string);
		}
		
		public function addBitmap(string:String):Bitmap 
		{
			this.skin = LoaderUtil.getFromCurrentDomain(string, true);
			return skin as Bitmap
		}
		
		public function add(displayObject:DisplayObject):void 
		{
			addChild(displayObject)
		}
		
		//--------------------------------------------------------------------------
		//
		//  Event Handlers
		//
		//--------------------------------------------------------------------------
		
		protected function handler_rollOut(e:MouseEvent):void 
		{
			growDown();
		}
		
		protected function handler_rollOver(e:MouseEvent):void 
		{
			growUp();
		}		
		
	}
}