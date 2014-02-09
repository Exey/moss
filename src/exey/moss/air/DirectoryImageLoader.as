package exey.moss.air 
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.FileListEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	/**
	 * Batch Reverse Directory Load Images Tool
	 * Example: <code>
		new DirectoryImageLoader(File.applicationDirectory, DIR, 
								function(f:File):void { imageDatas.push(new ImageData(f.url, f.name.substring(0, f.name.lastIndexOf(".")))) },
								function(b:Bitmap, loadedIndex:int, nextIndex:uint):void { imageDatas[loadedIndex].setBitmapData(b.bitmapData); percentLabel.text = Number((nextIndex / imageDatas.length) * 100).toFixed(2) + "%";},
								loadImagesComplete);
	  </code>
	 * 
	 * @author Exey Panteleev
	 */
	public class DirectoryImageLoader 
	{
		protected var currentIndex:uint = 0;
		protected var imageUrls:Array = [];
		
		protected var dirName:String;
		protected var onImageListed:Function;
		protected var onImageLoad:Function;
		protected var onAllLoad:Function;
		protected var onNext:Function;
		protected var root:File;
		protected var onImageListingComplete:Function;
		
		/**
		 * 
		 * @param	root
		 * @param	dirName
		 * @param	onImageListed  must return Boolean
		 * @param	onImageLoad
		 * @param	onAllLoad
		 * @param	onNext
		 * @param	onImageListingComplete
		 */
		public function DirectoryImageLoader(root:File, dirName:String, onImageListed:Function, onImageLoad:Function, onAllLoad:Function = null, onNext:Function = null, onImageListingComplete:Function = null, startListing:Boolean = true) 
		{
			this.onImageListingComplete = onImageListingComplete;
			this.onNext = onNext;
			this.onAllLoad = onAllLoad;
			this.onImageLoad = onImageLoad;
			this.onImageListed = onImageListed;
			this.dirName = dirName;
			this.root = root;
			if(startListing)
				start();
		}
		
		protected function start():void {
			root.addEventListener(FileListEvent.DIRECTORY_LISTING, dir_directoryListing);
			root.getDirectoryListingAsync();
		}
		
		protected function dir_directoryListing(event:FileListEvent):void {
			root.removeEventListener(FileListEvent.DIRECTORY_LISTING, dir_directoryListing);
			var contents:Array = event.files;
			var f:File;
			for (var i:uint = 0; i < contents.length; i++) {
				f = contents[i] as File;
				if (f.isDirectory && f.name == dirName) {
					f.addEventListener(FileListEvent.DIRECTORY_LISTING, dir_directoryListing, false, 0, true);
					f.getDirectoryListingAsync();
				} else if(!f.isDirectory && event.target.name == dirName){
					var listedReturn:* = onImageListed.apply(null, [f]);
					if(listedReturn != false)
						imageUrls.push(f.url);
				}
				// listing complete
				if ((i + 1) == contents.length && event.target.name == dirName) {
					if (onImageListingComplete != null) onImageListingComplete.apply();
					loadNext()
				}
			}			
		}
		
		protected function loadNext():void {
			//trace("3:", imageUrls.length, currentIndex, currentIndex >= imageUrls.length)
			if (currentIndex >= imageUrls.length) {
				if(onAllLoad != null)
					onAllLoad.apply()
				return;
			}
			var f:File=File.applicationDirectory.resolvePath(imageUrls[currentIndex]);
			if ( onNext != null) onNext.apply(null, [f]);
			var fs:FileStream=new FileStream();
			var ba:ByteArray=new ByteArray();
			//trace(f.nativePath)
			fs.open(f, FileMode.READ);
			fs.readBytes(ba);
			fs.close();
			
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loaded);
			loader.loadBytes(ba);
		}
		
		protected function loaded(e:Event):void {
			onImageLoad.apply(null, [e.target.content as Bitmap, currentIndex, ++currentIndex]);
			loadNext();
		}		
		
	}
}