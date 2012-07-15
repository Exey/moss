package exey.moss.utils 
{
	import flash.events.MouseEvent;
	import flash.utils.describeType;
	import flashx.textLayout.conversion.TextConverter;
	import flashx.textLayout.elements.Configuration;
	import flashx.textLayout.elements.FlowElement;
	import flashx.textLayout.elements.FlowLeafElement;
	import flashx.textLayout.elements.LinkElement;
	import flashx.textLayout.elements.ParagraphElement;
	import flashx.textLayout.elements.SpanElement;
	import flashx.textLayout.elements.TextFlow;
	import flashx.textLayout.events.FlowElementMouseEvent;
	import flashx.textLayout.formats.TextDecoration;
	import flashx.textLayout.formats.TextLayoutFormat;
	/**
	 * Utils for easy work with Text Layout Engine
	 * @author Exey
	 */
	public class TextFlowUtil{
		
		public static function createLink(text:String, linkId:String, listener:Function, fontSize:uint, color:uint = 0x000000):LinkElement {
			var link:LinkElement = new LinkElement();
			link.id = linkId;
			link.addEventListener(FlowElementMouseEvent.CLICK, listener, false, 0, true);

			var s:SpanElement = new SpanElement();
			s.color = 0xFF0000;
			s.text = text;
			s.fontSize = fontSize;
			link.addChild(s);
			return link;
		}
		
		/**
		 * 
		 * @param	text
		 * @param	p
		 * @param	color
		 * @param	format // for resolve conflict with Flex4 beta2 vs. Nighty Builds, by defaults "textFieldHTMLFormat" for Nighty Builds
		 */
		public static function parseHTML(text:String, p:ParagraphElement, color:uint = 0x000000, format:String = "textFieldHTMLFormat"):void {
			// parsing HTML
			var htmlParagraph:FlowElement;
			var leaf:FlowLeafElement;  
			var htmlLeafs:Array = [];
			var htmlTextFlow:TextFlow;
			
			/*// Configuration passed to any TextFlows the default importer is importing
			var config:Configuration = new Configuration();
			// take control of the tabkey - normally it will be ignored and used to move between widgets.
			// without this no easy way to insert tabs
			config.manageTabKey = true;
			// make the links initial display 24 point underline red
            var ca:TextLayoutFormat = new TextLayoutFormat();
            ca.color = '#ff0000';
            ca.textDecoration=TextDecoration.UNDERLINE;
            config.defaultLinkNormalFormat = ca;	*/	
			//htmlTextFlow = TextConverter.importToFlow(text, format, config);
			
			htmlTextFlow = TextConverter.importToFlow(text, format);
			

			////trace("addMessage", htmlTextFlow.numChildren, text)
			htmlParagraph =	htmlTextFlow.getChildAt(0); // just get first, you can also for (var j:int = 0; j < htmlTextFlow.numChildren; j++) {
			////trace("- ", htmlParagraph, htmlParagraph.getText(), htmlParagraph.textLength, text.length, ParagraphElement(htmlParagraph).getFirstLeaf(), ParagraphElement(htmlParagraph).getLastLeaf());
			// collecting leafs from htmlTextFlow
			leaf = htmlTextFlow.getFirstLeaf()
			htmlLeafs.push(leaf);
			while (leaf = leaf.getNextLeaf()) {
				htmlLeafs.push(leaf);
			}
			// adding leafs to paragraph, where is links?
			for (var j:int = 0; j < htmlLeafs.length; j++) {
				leaf = htmlLeafs[j];
				//leaf.color = channelColor;
				leaf.color = color;
				p.addChild(htmlLeafs[j]);
				
				
				
				////trace("-- ", leaf, SpanElement(leaf).text);
				////trace("-- ", describeType(leaf).@name, leaf.format.color, FlowLeafElement(leaf).text);
			}
			
			//return p;
		}

	}
}