package exey.moss.gui.comps.window 
{
	import exey.moss.gui.comps.tilelist.TileCarousel;
	import flash.display.DisplayObjectContainer;
	
	/**
	 * Window with tile carousel
	 * @author Exey Panteleev
	 */
	public class CarouselWindow extends Window 
	{
		public var carousel:TileCarousel;
		
		public function CarouselWindow(parent:DisplayObjectContainer, width:Number, height:Number, title:String) 
		{
			super(parent, width, height, title);
		}
		
		//--------------------------------------------------------------------------
		//
		//  TileList Carousel
		//
		//--------------------------------------------------------------------------		
		
		public function initCarousel(itemClass:Class, tileItems:Array, allDatas:Array, iconsUrl:String, step:uint = 6, horizontalGap:Number = 5, verticalGap:Number = 0):void {
			// gui
			if (carousel) carousel.destroy();
			carousel = new TileCarousel(_container, 50, 100, 3, 10);
			carousel.step = step;
			carousel.horizontalGap = horizontalGap;
			carousel.verticalGap = verticalGap;
			carousel.initialize(tileItems, itemClass);
			// data
			var pageIndex:uint = 0;
			carousel.prevPageClick.add(function():void {
				if (pageIndex > 0) pageIndex--;
				loadIcons(pageIndex, allDatas, iconsUrl);
			})
			carousel.nextPageClick.add(function():void {
				if (pageIndex <= int(allDatas.length/carousel.step)) pageIndex++;
				loadIcons(pageIndex, allDatas, iconsUrl);
			})
			loadIcons(pageIndex, allDatas, iconsUrl);
		}
		
		private function loadIcons(pageIndex:uint, allDatas:Array, iconsUrl:String):void {
			carousel.showRightArrow();
			carousel.showLeftArrow();
			if (pageIndex == 0)	carousel.hideLeftArrow();
			if (pageIndex == int((allDatas.length - 1)/carousel.step)) carousel.hideRightArrow();
			// icons loading queue
			carousel.iconUrls = [];
			if ((allDatas.length - pageIndex*carousel.step) > 0)
				for (var i:int = pageIndex*carousel.step; i < carousel.step + pageIndex*carousel.step; i++)
					if (allDatas[i]) 
						carousel.iconUrls.push(allDatas[i]);
			carousel.loadNextIcon(null, "", "", iconsUrl);
		}
		
	}

}