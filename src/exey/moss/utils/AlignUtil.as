package exey.moss.utils
{
	import exey.moss.gui.abstract.ComponentAbstract;
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
		
		static public function toHorizontalCenter( obj:Object, container:Object =  null ):void {
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
		
		static public function toCenter( obj:Object, container:Object =  null, offsetX:Number = 0, offsetY:Number = 0):void {
			if (container == null) {
				obj.x = -obj.width * 0.5 + offsetX;
				obj.y = -obj.height * 0.5 + offsetY;
			}else {
				obj.x = (container.width - obj.width) * 0.5 + offsetX;
				obj.y = (container.height - obj.height) * 0.5 + offsetY;
			}
			//deb(obj.x, obj.y);
		}
		
		static public function toRight(obj:DisplayObject, containerWidth:Number, shift:Number = 0):void 
		{
			obj.x = containerWidth - obj.width+shift;
		}
		
		static public function toTopLeft( obj:DisplayObject, container:DisplayObjectContainer ):void
		{
			obj.x = container.x;
			obj.y = container.y;
		}
		
		static public function toTopCenter( obj:DisplayObject, container:DisplayObjectContainer ):void {
			obj.x = (container.width - obj.width) * 0.5;
			obj.y = container.y;
		}
		
		static public function toTopRight( obj:DisplayObject, container:DisplayObjectContainer ):void
		{
			obj.x = container.width - obj.width;
			obj.y = container.y;
		}
		
		static public function toBottomRight( obj:DisplayObject, container:DisplayObjectContainer ):void
		{
			obj.x = container.width - obj.width;
			obj.y = container.height - obj.height;
		}
		
		static public function toBottomCenter( obj:DisplayObject, container:DisplayObjectContainer, offsetX:Number = 0, offsetY:Number = 0):void
		{
			obj.x = (container.width - obj.width) * 0.5 + offsetX;
			obj.y = container.height - obj.height + offsetY;
		}
		
		static public function toBottomLeft( obj:DisplayObject, container:DisplayObjectContainer ):void
		{
			obj.x = container.x;
			obj.y = container.height - obj.height;
		}
		
		static public function centerXToPosition(obj:DisplayObject, x:Number, y:Number = NaN):void 
		{
			obj.x = x - obj.width * 0.5;
			if (!isNaN(y))
				obj.y = y;
		}
		
		static public function toVerticalCenter(obj:DisplayObject, containerHeight:Number, offsetY:Number = 0):void 
		{
			obj.y = (containerHeight - obj.height)*0.5+offsetY;
		}
		
		static public function toBottom(obj:DisplayObject, containerHeight:Number, offsetY:Number = 0):void 
		{
			obj.y = containerHeight - obj.height+offsetY;
		}
		
	}
}