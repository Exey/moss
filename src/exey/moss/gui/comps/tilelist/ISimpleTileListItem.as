package exey.moss.gui.comps.tilelist {
	
	/**
	 * ...
	 * @author Exey Panteleev
	 */
	public interface ISimpleTileListItem {
		
		function set data(value:Object):void
		function get data():Object
		function get itemWidth():Number
		function get itemHeight():Number
		function destroy():void
		
	}
}