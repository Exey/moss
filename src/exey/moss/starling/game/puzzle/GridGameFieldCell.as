package exey.moss.starling.game.puzzle {
	import exey.moss.gui.comps.text.TextFieldLabel;
	import flash.geom.Point;
	import flash.text.TextFormat;
	import starling.display.Image;
	import starling.display.Sprite;
	
	/**
	 * GridGameField Cell
	 * @author Exey Panteleev
	 */
	public class GridGameFieldCell extends GridGameFieldElementAbstract {
		// logic
		public var empty:Boolean = true;
		
		public function get position():Point {
			return new Point(gridX, gridY);
		}
		
		public function GridGameFieldCell(gridX:int, gridY:int, skin:Image) {
			super();
			this.gridY = gridY;
			this.gridX = gridX;
			addChild(skin);
		}
		
		public function clean():void {
			empty = true;
		}		
	
		//private function addDebugText(sprite:flash.display.Sprite):void {
			//var tf:TextFieldLabel = new TextFieldLabel(sprite, 0, 5, new TextFormat("Tahoma", 11, 0x676767, true), gridX + "," + gridY);			
		//}
		
		public function destroy():void {
			if(this.parent) parent.removeChild(this)
		}
		
		public function toString():String {
			return "[Cell "+gridX+" "+gridY+"  empty: "+empty+"]";
		}
		
	}
}