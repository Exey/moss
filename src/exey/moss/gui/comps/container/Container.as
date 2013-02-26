package exey.moss.gui.comps.container
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Exey Panteleev
	 */
	public class Container extends Sprite
	{
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		public function Container(parent:DisplayObjectContainer, width:Number = 0, height:Number = 0)
		{
			this.graphics.drawRect(0, 0, width, height);
			if(parent)
				parent.addChild(this);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		private var _locked:Boolean;
		public function get locked():Boolean
		{
			return _locked;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------
		
		public function lock():void
		{
			if (_locked)
				return;
			_locked = true;
			mouseChildren = false;
			mouseEnabled = false;
		}
		
		public function unlock():void
		{
			if (!_locked)
				return;
			_locked = true;
			mouseChildren = true;
			mouseEnabled = true;
		}
	}

}