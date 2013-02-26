package exey.moss.utils 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.utils.describeType;
	import flash.utils.getQualifiedClassName;
	/**
	 * ...
	 * @author Exey Panteleev
	 */
	public class StageUtil 
	{
		
		static public function setScaleAndAlign(s:Stage, scaleMode:String = "noScale", align:String = "TL"):void 
		{
			s.scaleMode = scaleMode
			s.align = align
		}
		
		static public function traceParents(displayObject:DisplayObject):String 
		{
			var s:String;
			var spaces:String = "";
			if(displayObject.parent)
			{
				s = displayObject.toString() +" ["+ClassUtil.getExtends(displayObject).join("]>[")+"]";
				countParents(displayObject);
			}
			
			function countParents(dObj:DisplayObject):void 
			{
				spaces += "  ";
				//trace("--", dObj.parent)
				s += "\n"+spaces+"|-"+dObj+" ["+ClassUtil.getExtends(dObj).join("]>[")+"]";
				if (dObj.parent is DisplayObject) 
					countParents(dObj.parent);
			}
			return s;
		}
		
		static public function countAllChilds(container:*, showMoreThanMin:Boolean = false, minNumObjects:uint = 20):String
		{
			var prevCountArray:Array;
			var prevTotal:uint;
			
			var total:uint = 0;
			var i:int;
			var k:int;
			var n:int;
			var s:String;
			var result:String = "";
			var countArray:Array;
			var countArrayDef:Array = ["Total", "Other", "MovieClip", "Sprite", "TextField", "StaticText", "Shape", "SimpleButton", "Bitmap", "TextFieldLabel", "magicui.button", "game.view.gui"];
			var dobj:Sprite;
			var diff:int;
			for (i = 0; i < container.numChildren; i++) {
				countArray = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
				dobj = container.getChildAt(i) as Sprite;
				//////trace(container, dobj)
				if (!dobj) continue;
				countChildrenInContainer(dobj, countArray)
				//////trace("+ " + dobj.name+":", countArray[0])
				s = ""
				for (k = 1; k < countArray.length; k++) {
					var children:int = countArray[k]
					if (children > 0) {
						//if ( k != 1 ) s += "\n                     ";
						//s+= children+" - "+countArrayDef[k]+", ";
						s+= countArrayDef[k]+": "+children+", ";
					}
				}
				total += countArray[0];
				diff = countArray[0] - prevCountArray[i];

				if ((showMoreThanMin && countArray[0] > minNumObjects) || !showMoreThanMin)
					result += "  " + countArray[0] + "{"+diff+"} - " + dobj.name + " ( " + s + ") \n";
				prevCountArray[i] = countArray[0];
			}
			diff = total - prevTotal

			result += "-------------------- " + total + "{"+diff+"} DisplayObjects TOTAL";
			prevTotal = total;

			return result;
		}

		/**
		 * Go through all scene DispalyObjects recursive
		 */
		static private function countChildrenInContainer(currentChild:Sprite, countArray:Array):void
		{
			//////trace(currentChild, getQualifiedClassName(currentChild));
			var i:int = 0;
			var num:int = currentChild.numChildren;
			if (num > 0) {
				// count currentChild
				defineTypeAndCount(currentChild, countArray);
				countArray[0]++;
				for (i; i < num; i++) {
					var nextChild:Sprite = currentChild.getChildAt(i) as Sprite;
					if (nextChild && nextChild.numChildren > 0) {
						countChildrenInContainer(nextChild, countArray); // recursion
					}else {
						// count if no children in nextChild
						defineTypeAndCount(currentChild.getChildAt(i), countArray);
						countArray[0]++;
					}
				}
			} else {
				// count if no children in currentChild
				defineTypeAndCount(currentChild, countArray);
				countArray[0]++;
			}
		}

		static protected function defineTypeAndCount(currentChild:DisplayObject, countArray:Array):void
		{
			var className:String = getQualifiedClassName(currentChild);
			var splitClassName1:Array = className.split("::")
			var splitClassName2:Array = splitClassName1[0].split(".")
			var name2:String = splitClassName2[0]+"."+splitClassName2[1]
			var name3:String = splitClassName2[0]+"."+splitClassName2[1]+"."+splitClassName2[2]
			if 		  (className == "flash.display::MovieClip") { countArray[2]++; //////trace(currentChild, currentChild.name, "(" + currentChild.x + ", " + currentChild.y + ")", currentChild.width + "x" + currentChild.height, "|", currentChild.parent, currentChild.parent.name);
			} else if (className == "flash.display::Sprite") { countArray[3]++
			} else if (className == "flash.text::TextField") { countArray[4]++; //////trace(currentChild, currentChild.name, "(" + currentChild.x + ", " + currentChild.y + ")", currentChild.width + "x" + currentChild.height, "|", currentChild.parent, currentChild.parent.name);
			} else if (className == "flash.text::StaticText") { countArray[5]++
			} else if (className == "flash.display::Shape") { countArray[6]++; //////trace(currentChild.parent, currentChild.parent.name , "|", currentChild, currentChild.name, "(" + currentChild.x + ", " + currentChild.y + ")", currentChild.width + "x" + currentChild.height);
			} else if (className == "flash.display::SimpleButton") { countArray[7]++
			} else if (className == "flash.display::Bitmap") { countArray[8]++
			} else if (className == "magicui.text::TextFieldLabel") { countArray[9]++
			} else if (name2 == "magicui.button") { countArray[10]++
			} else if (name3 == "game.view.gui") { countArray[11]++
			//} else if (className.substr(0,26) == "magicengine.room::FieldCell") { countArray[11]++
			}else {
				//////trace(className, currentChild)
				countArray[1]++;
			}
		}
		
	}
}