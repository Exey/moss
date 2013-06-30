package exey.moss.gui.comps.container
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	
	/**
	 * Basic Container with lock
	 * @author Exey Panteleev
	 */
	public class Container extends Sprite
	{
		private var _locked:Boolean;
		public function get locked():Boolean{ return _locked;}
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		public function Container(parent:DisplayObjectContainer, width:Number = 0, height:Number = 0, name:String="", xPos:Number = NaN, yPos:Number = NaN)
		{
			if(name.length) this.name = name;
			this.graphics.drawRect(0, 0, width, height); // hack to set width and height
			if (parent) parent.addChild(this);
			if (!isNaN(xPos)) this.x = xPos;
			if (!isNaN(yPos)) this.y = yPos;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------
		
		public function move(xpos:Number, ypos:Number):void
		{
			this.x = xpos;
			this.y = ypos;
		}
		
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
		
		override public function toString():String 
		{
			return "[Container "+name+"]"
		}
	}
}