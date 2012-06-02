package exey.moss.mngr
{
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	
	/**
	 * Global Keyboard handler
	 * @author Exey Panteleev
	 */
	public class KeyboardManager
	{
		
		private var stage:Stage;
		private var isEnable:Boolean = true;
		//flags
		static public var isShift:Boolean;
		static public var isCtrl:Boolean;
		
		static private var bindings:Array = [];
		
        static public const NUMBER_0:uint = 48;
        static public const NUMBER_1:uint = 49;
        static public const NUMBER_2:uint = 50;
        static public const NUMBER_3:uint = 51;
        static public const NUMBER_4:uint = 52;
        static public const NUMBER_5:uint = 53;
        static public const NUMBER_6:uint = 54;
        static public const NUMBER_7:uint = 55;
        static public const NUMBER_8:uint = 56;
        static public const NUMBER_9:uint = 57;
        static public const A:uint = 65;
        static public const B:uint = 66;
        static public const C:uint = 67;
        static public const D:uint = 68;
        static public const E:uint = 69;
        static public const F:uint = 70;
        static public const G:uint = 71;
        static public const H:uint = 72;
        static public const I:uint = 73;
        static public const J:uint = 74;
        static public const K:uint = 75;
        static public const L:uint = 76;
        static public const M:uint = 77;
        static public const N:uint = 78;
        static public const O:uint = 79;
        static public const P:uint = 80;
        static public const Q:uint = 81;
        static public const R:uint = 82;
        static public const S:uint = 83;
        static public const T:uint = 84;
        static public const U:uint = 85;
        static public const V:uint = 86;
        static public const W:uint = 87;
        static public const X:uint = 88;
        static public const Y:uint = 89;
        static public const Z:uint = 90;	
		
		public function KeyboardManager(stage:Stage)
		{
			this.stage = stage;
			enable();
		}
		
		public function enable():void
		{
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyboardCommand);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyboardCommand);
		}
		
		public function disable():void
		{
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyboardCommand);
			stage.removeEventListener(KeyboardEvent.KEY_UP, onKeyboardCommand);
		}
		
		
		/**
		 * парсинг клавиатурных команд
		 * @param	e
		 */
		private function onKeyboardCommand(e:KeyboardEvent):void
		{
			var isKeyDown:Boolean = (e.type == KeyboardEvent.KEY_DOWN);
			////////trace(stage.focus);
			var i:int;
			if(isKeyDown && isEnable){
				switch(e.keyCode) {
					case 17:
						//CTRL
						KeyboardManager.isCtrl = true;
					break;					
					case 16:
					// SHIFT
						KeyboardManager.isShift = true;
					break;
				}
			for (i = 0; i < KeyboardManager.bindings.length; i++) 
			{
				if (e.keyCode == KeyboardManager.bindings[i][0])
					KeyboardManager.bindings[i][1].call();
			}	
			}else {
				// KEY_UP
				////////trace("KEY_UP " + e.keyCode);
				if (e.keyCode == 16) {
					KeyboardManager.isShift = false;
				}else if (e.keyCode == 17) {
					KeyboardManager.isCtrl = false;
				}
			}
		}
		
		static public function bind(keyCode:uint, handler:Function):void 
		{
			KeyboardManager.bindings.push([keyCode, handler])
		}		
	}
}