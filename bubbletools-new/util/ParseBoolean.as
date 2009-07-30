// bubbletools.* ===============================================================================
// BubbleTools™ Web Application and User Interface Component Architecture for Actionscript 3
// ©2007 Michael Szypula.  Any modifications to this file must keep this license block intact.
// Developer : Michael Szypula
// Contact : michael.szypula@gmail.com
// License Information : Contact Developer to obtain license agreement.
// =================================================================================================

package bubbletools.util {
	
	public class ParseBoolean {
		
		private static var _instance:ParseBoolean = null;

		public static function instance():ParseBoolean {
			if (ParseBoolean._instance == null) {
				ParseBoolean._instance = new ParseBoolean();
			}
			return ParseBoolean._instance;
		}
	
		public function ParseBoolean(){}
	
		public static function getValue(boolString:String):Boolean {
			var boolValue:Boolean = false;
			if(boolString == "true") {
				boolValue = true;
			}
			return(boolValue);
		}
	
	}

}