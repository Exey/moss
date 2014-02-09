package exey.moss.starling.game.puzzle {
	import exey.moss.starling.gui.comps.container.Container;
	import exey.moss.utils.MathUtil;
	import flash.geom.Point;
	import org.osflash.signals.Signal;
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.textures.Texture;
	
	/**
	 * Starling GridGameField contains field elements
	 * Only one element per cell
	 * Only one selected element
	 * @author Exey Panteleev
	 */
	public class GridGameField extends Container  {
		
		protected const NEXT_TOUCH_DELAY:Number = 500;
		protected const DEBUG_NEXT_TOUCH_DELAY:Number = 1000;
		
		// grid and cells
		protected var cellTexture:Texture;
		public var cellSize:Number;
		public var cells:Array;
		public var gridWidth:Number;
		public var gridHeight:Number;
		// elements
		public var elements:Array;
		public var selectedElement:GridGameFieldElementAbstract;
		// signals
		public var pathChoosen:Signal = new Signal();
		public var elementUnselected:Signal = new Signal();
		public var noEmptyCells:Signal = new Signal();
		// logic
		protected var lastElementTouch:Number = NaN;
		protected var lastCellTouch:Number = NaN;
		// handlers
		protected var selectHandler:Function;
		protected var unselectHandler:Function;
		
		public function GridGameField(parent:DisplayObjectContainer, width:Number, height:Number, gridWidth:Number, gridHeight:Number, cellTexture:Texture, selectHandler:Function = null, unselectHandler:Function = null)
		{
			super(parent, width, height);
			this.cellTexture = cellTexture;
			this.cellSize = Math.max(cellTexture.width, cellTexture.height);
			this.unselectHandler = unselectHandler;
			this.selectHandler = selectHandler;
			this.gridHeight = gridHeight;
			this.gridWidth = gridWidth;
		}
		
		//--------------------------------------------------------------------------
		//
		//  API
		//
		//--------------------------------------------------------------------------
		
		public function addElement(el:GridGameFieldElementAbstract, sx:Number, sy:Number):void
		{
			el.x = sx;
			el.y = sy;
			el.pivotX = el.width*0.5;
			el.pivotY = el.height*0.5;
			addChild(el);
		}
		
		public function addAndRegisterElement(el:GridGameFieldElementAbstract):void
		{
			var sx:Number = el.gridX * cellSize + cellSize*0.5; 
			var sy:Number = el.gridY * cellSize + cellSize*0.5;
			addElement(el, sx, sy);
			registerElement(el);
		}
		
		public function getElement(gridX:int, gridY:int):GridGameFieldElementAbstract
		{
			var el:GridGameFieldElementAbstract;
			var elementsLength:uint = elements.length;
			for (var i:int = 0; i < elementsLength; i++) {
				el = elements[i];
				if (el.gridX == gridX && el.gridY == gridY)
					return el
			}
			return null;
		}
		
		public function getCell(gridX:int, gridY:int):GridGameFieldCell
		{
			var c:GridGameFieldCell;
			var cellsLength:uint = cells.length;
			for (var i:int = 0; i < cellsLength; i++) {
				c = cells[i];
				if (c.gridX == gridX && c.gridY == gridY)
					return c
			}
			return null;
		}
		
		public function removeElement(el:GridGameFieldElementAbstract):void
		{
			var index:uint = elements.indexOf(el);
			if(index > -1){
				elements.splice(index, 1);
				if (this.contains(el)) this.removeChild(el);
			}
			getCell(el.gridX, el.gridY).empty = true;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Optional API
		//
		//--------------------------------------------------------------------------
		
		public function gridToScreen(p:Point):Point
		{
			p.x = p.x * cellSize + cellSize*0.5;
			p.y = p.y * cellSize + cellSize*0.5;
			return p;
		}
		
		public function getEmptyCells():Array
		{
			var cc:Array = cells.concat();
			var nc:Array = cc.filter(function(c:GridGameFieldCell, ...rest):Boolean { return c.empty; } ); 
			return nc
		}
		
		public function getRadomEmptyCellPoint():Point
		{
			var emptyCells:Array = getEmptyCells();
			return emptyCells[MathUtil.random(0, emptyCells.length - 1, true)].position;
		}
		
		public function cleanCells():void
		{
			var cellslength:int = cells ? cells.length : 0
			for (var i:int = 0; i < cellslength; i++) cells[i].clean();
		}
		
		public function addCells(cellAlpha:Number = 1):void
		{
			cells = [];
			var x:int;
			var y:int;
			var sx:Number = -cellSize*0.5;
			var sy:Number = cellSize*0.5;
			var cell:GridGameFieldCell;
			for (y = 0; y < gridHeight; y++) {
				sx = -cellSize*0.5
				for (x = 0; x < gridWidth; x++) {
					sx += cellSize
					cell = new GridGameFieldCell(x, y, new Image(cellTexture));
					cell.alpha = cellAlpha;
					cell.x = sx
					cell.y = sy
					cell.pivotX = cell.width / 2.0;
					cell.pivotY = cell.height / 2.0;
					cells.push(cell);
					addChild(cell);
				}
				sy += cellSize
			}
			this.addEventListener(TouchEvent.TOUCH, touch_handler)
		}
		
		//--------------------------------------------------------------------------
		//
		//  Event handlers
		//
		//--------------------------------------------------------------------------
		
		protected function touch_handler(e:TouchEvent):void
		{
			if (locked) return;
			var touch:Touch = e.getTouch(this);
			if (touch) {
				CONFIG::debug {
					var now:Number = new Date().getTime();
					if (!isNaN(lastCellTouch) && (now - lastCellTouch) < DEBUG_NEXT_TOUCH_DELAY)
						return;
					lastCellTouch = now;
					if(!e.shiftKey) return
				}
				var loc:Point = touch.getLocation(this);
				var cell:GridGameFieldCell = getCell(int(loc.x/cellSize), int(loc.y/cellSize));
				var b:GridGameFieldElementAbstract = getElement(cell.gridX, cell.gridY);
				if (b) {
					elementTouch(b);
				} else if (selectedElement) {
					unselectHandler(selectedElement);
					pathChoosen.dispatch(selectedElement.gridX, selectedElement.gridY, cell.gridX, cell.gridY)
				}
			}
		}
		
		protected function elementTouch(el:GridGameFieldElementAbstract):void
		{
			if (locked) return;
			var now:Number = new Date().getTime();
			if (!isNaN(lastElementTouch) && (now - lastElementTouch) < NEXT_TOUCH_DELAY) return;
			lastElementTouch = now;
			if (selectedElement) {
				unselectHandler(selectedElement);
				elementUnselected.dispatch(selectedElement);
				selectedElement = null;
			} else if (!selectedElement) {
				selectedElement = el;
				selectHandler(selectedElement);
			} 
			//trace("elementTouch", ball, selectedElement);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected API
		//
		//--------------------------------------------------------------------------
		
		protected function registerElement(el:GridGameFieldElementAbstract):void
		{
			getCell(el.gridX, el.gridY).empty = false;
			elements.push(el);
		}
		
	}
}