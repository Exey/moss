package exey.moss.utils
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	/**
	 * ...
	 * @author
	 */
	public class AlignUtil {
		
		static public function toCenterText( obj:DisplayObject, container:DisplayObjectContainer):void {
			obj.x = (container.width - obj.width) * 0.5;
			obj.y = (container.height - obj.height) * 0.5+2;
		}
		
		static public function toHorizontalCenter( obj:DisplayObject, container:DisplayObjectContainer =  null ):void {
			if (container == null) {
				obj.x = -obj.width * 0.5;
			}else {
				obj.x = (container.width - obj.width) * 0.5;
			}
		}
		
		//static public function toCenterByWidthAndHeight( objWidth:DisplayObject, objHeight:DisplayObject, containerWidth:Number, containerHeight:Number, offsetX:Number = 0, offsetY:Number = 0 ):void {
		static public function toCenterByWidthAndHeight( obj:DisplayObject, containerWidth:Number, containerHeight:Number, offsetX:Number = 0, offsetY:Number = 0 ):void {
			obj.x = (containerWidth - obj.width) * 0.5 + offsetX;
			obj.y = (containerHeight - obj.height) * 0.5 + offsetY;
		}
		
		static public function toCenter( obj:DisplayObject, container:DisplayObjectContainer =  null, offsetX:Number = 0, offsetY:Number = 0):void {
			if (container == null) {
				obj.x = -obj.width * 0.5 + offsetX;
				obj.y = -obj.height * 0.5 + offsetY;
			}else {
				obj.x = (container.width - obj.width) * 0.5 + offsetX;
				obj.y = (container.height - obj.height) * 0.5 + offsetY;
			}
			//stackTrace(obj.x, obj.y);
		}
		
		static public function toTopLeft( obj:DisplayObject, container:DisplayObjectContainer ):void {
			obj.x = container.x;
			obj.y = container.y;
		}
		
		static public function toTopCenter( obj:DisplayObject, container:DisplayObjectContainer ):void {
			obj.x = (container.width - obj.width) * 0.5;
			obj.y = container.y;
		}
		
		static public function toTopRight( obj:DisplayObject, container:DisplayObjectContainer ):void {
			obj.x = container.width - obj.width;
			obj.y = container.y;
		}
		
		static public function toBottomRight( obj:DisplayObject, container:DisplayObjectContainer ):void {
			obj.x = container.width - obj.width;
			obj.y = container.height - obj.height;
		}
		
		static public function toBottomCenter( obj:DisplayObject, container:DisplayObjectContainer ):void {
			obj.x = (container.width - obj.width) * 0.5;
			obj.y = container.height - obj.height;
		}
		
		static public function toBottomLeft( obj:DisplayObject, container:DisplayObjectContainer ):void {
			obj.x = container.x;
			obj.y = container.height - obj.height;
		}
		
	}

}