package exey.moss.gui.comps.button 
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Exey Panteleev
	 */
	public class HoverButton extends EmptyButton 
	{
		private var _hoverSkin:Sprite;		
		public function get hoverSkin():Sprite { return _hoverSkin;}		
		public function set hoverSkin(value:Sprite):void { _hoverSkin = value;}
		
		public function HoverButton(parent:DisplayObjectContainer, xpos:Number, ypos:Number, handler:Function, skin:Sprite, hoverSkin:Sprite) 
		{
			super(parent, xpos, ypos, handler);
			this.skin = skin;
			this.hoverSkin = hoverSkin;
			addChild(hoverSkin);
			this.addEventListener(MouseEvent.ROLL_OVER, handler_RollOver);
			this.addEventListener(MouseEvent.ROLL_OUT, handler_RollOut);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Event handlers
		//
		//--------------------------------------------------------------------------		
		
		private function handler_RollOver(e:MouseEvent):void 
		{
			skin.visible = false;
			hoverSkin.visible = true;
		}		
		
		private function handler_RollOut(e:MouseEvent):void 
		{
			skin.visible = true;
			hoverSkin.visible = false;
		}
		
	}
}