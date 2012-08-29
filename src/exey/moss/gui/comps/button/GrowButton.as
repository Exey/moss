package exey.moss.gui.comps.button 
{
	import exey.moss.utils.LoaderUtil;
	import flash.display.Bitmap;
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	
	/**
	 * ...
	 * @author Exey Panteleev
	 */
	public class GrowButton extends EmptyButton 
	{
		private var growRatio:Number;
		
		protected var _selected:Boolean;		
		public function get selected():Boolean
		{
			return selected;
		}
		public function set selected(value:Boolean):void 
		{
			_selected = value;
			if (_selected)
				this.skin.filters = [new GlowFilter()];
			else
				this.skin.filters = [];
		}
		
		public function GrowButton(parent:DisplayObjectContainer, xpos:Number, ypos:Number, handler:Function, growRatio:Number = 1.1) 
		{
			super(parent, xpos, ypos, handler);
			this.growRatio = growRatio;
			this.addEventListener(MouseEvent.ROLL_OVER, handler_rollOver);
			this.addEventListener(MouseEvent.ROLL_OUT, handler_rollOut);
		}
		
		private function handler_rollOut(e:MouseEvent):void 
		{
			growDown();
		}
		
		private function handler_rollOver(e:MouseEvent):void 
		{
			growUp();
		}
		
		protected function growDown():void 
		{
			this.skin.scaleX = 1;
			this.skin.scaleY = 1;
		}
		
		protected function growUp():void 
		{
			this.skin.scaleX = growRatio;
			this.skin.scaleY = growRatio;
		}
		
		public function refreshOriginXY():void 
		{
			trace("3:FIX GrowButton Origin");
		}		
		
		public function addMovieClip(string:String):void 
		{
			this.skin = LoaderUtil.getFromCurrentDomain(string);
		}
		
		public function addBitmap(string:String):Bitmap 
		{
			this.skin = LoaderUtil.getFromCurrentDomain(string, true);
			return skin as Bitmap
		}
		
	}

}