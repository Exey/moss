package exey.moss.gui.comps.button 
{
	import exey.moss.gui.abstract.ComponentAbstract;
	import flash.display.Bitmap;
	import flash.display.DisplayObjectContainer;
	
	/**
	 * ...
	 * @author Exey Panteleev
	 */
	public class ToogleButton extends EmptyButton
	{
		protected var offSkin:Bitmap;
		protected var onSkin:Bitmap;
		
		protected var _selected:Boolean;		
		public function get selected():Boolean
		{
			return _selected;
		}
		public function set selected(value:Boolean):void 
		{
			_selected = value;
			if (_selected) this.skin = onSkin;
			else this.skin = offSkin;
		}
		
		public function ToogleButton(parent:DisplayObjectContainer, xpos:Number, ypos:Number, onSkin:*, offSkin:*, selected:Boolean, handler:Function) 
		{
			super(parent, xpos, ypos, handler);
			this.onSkin = onSkin as Bitmap;
			this.offSkin = offSkin as Bitmap;
			this.skin = onSkin as DisplayObjectContainer;		
		}
		
	}

}