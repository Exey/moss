package exey.moss.gui.comps.tilelist 
{
	import exey.moss.gui.comps.button.EmptyButton;
	import exey.moss.mngr.data.AssetData;
	import exey.moss.mngr.AssetManager;
	import exey.moss.utils.DrawUtil;
	import flash.display.Bitmap;
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	import org.osflash.signals.Signal;
	
	/**
	 * ...
	 * @author Exey Panteleev
	 */
	public class TileCarousel extends TileList 
	{
		public var leftArrow:EmptyButton;
		public var rightArrow:EmptyButton;
		public var prevPageClick:Signal;
		public var nextPageClick:Signal;
		
		public var iconUrls:Array
		
		public function TileCarousel(parent:DisplayObjectContainer, xpos:Number, ypos:Number, columns:uint=3, gap:Number=20) 
		{
			super(parent, xpos, ypos, columns, gap);
			prevPageClick = new Signal();
			nextPageClick = new Signal();			
			leftArrow = new EmptyButton(this, -36, 120, onLeft);
			//PlaceUtil.to(leftArrow, "LeftArrowSkin");
			DrawUtil.leftArrow(leftArrow.graphics, 0x6A5220, 24, 48);
			
			rightArrow = new EmptyButton(this, 400, 120, onRight);
			//PlaceUtil.to(rightArrow, "RightArrowSkin");
			DrawUtil.rightArrow(rightArrow.graphics, 0x6A5220, 24, 48);
		}
		
		public function loadNextIcon(resourceData:AssetData = null, id:String = "", iconUrl:String = "", dataUrl:String = ""):void {
			if (resourceData) {
				addIconByProperty(resourceData.content, "id", id);
			}
			if (iconUrls.length > 0) {
				var url:Object = iconUrls.splice(0, 1)[0];
				AssetManager.load(dataUrl+url.icon, loadNextIcon, url.id, url.icon, dataUrl);
			}
		}
		
		public function addIconByProperty(bitmap:Bitmap, propertyName:String, propertyValue:String):void {
			var shopTileListItem:Object = getItemByProperty(propertyName, propertyValue);
			//trace("1:ADD ICON", bitmap, propertyValue, shopTileListItem)
			if (shopTileListItem)
				shopTileListItem.addIcon(bitmap);
		}
		
		private function onLeft(e:MouseEvent):void {
			prev();
			prevPageClick.dispatch()
		}

		private function onRight(e:MouseEvent):void {
			next();
			nextPageClick.dispatch()
		}
	
		public function showRightArrow():void {
			rightArrow.visible = true;
		}
		
		public function hideRightArrow():void {
			rightArrow.visible = false;
		}
		
		public function showLeftArrow():void {
			leftArrow.visible = true;
		}
		
		public function hideLeftArrow():void {
			leftArrow.visible = false;
		}
	}
}