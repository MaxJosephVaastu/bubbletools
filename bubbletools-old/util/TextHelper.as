// bubbletools.* ===============================================================================
// BubbleTools™ Web Application and User Interface Component Architecture for Actionscript 3
// ©2007 Michael Szypula.  Any modifications to this file must keep this license block intact.
// Developer : Michael Szypula
// Contact : michael.szypula@gmail.com
// License Information : Contact Developer to obtain license agreement.
// =================================================================================================

package bubbletools.util {
	
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;

	public class TextHelper {
	
		// class to draw simple messages to the screen in a standard format
	
		public static function makeText(x:Number, y:Number, w:Number, h:Number, t:String):TextField {
			var textFormat:TextFormat = new TextFormat();
			textFormat.font = "Tahoma";
			textFormat.size = "10";
			textFormat.align = TextFormatAlign.LEFT;
			var newText = new TextField();
			newText.textColor = 0x000000;
			newText.width = w;
			newText.height = h;
			newText.x = x;
			newText.y = y;
			newText.selectable = false;
			newText.text = t;
			newText.wordWrap = true;
			newText.setTextFormat(textFormat);
			Main.instance().addChild(newText);
			return(newText);
		}
	}

}