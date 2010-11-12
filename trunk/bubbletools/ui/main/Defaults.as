// bubbletools.* ===============================================================================
// BubbleTools™ Web Application and User Interface Component Architecture for Actionscript 3
// ©2007 Michael Szypula.  Any modifications to this file must keep this license block intact.
// Developer : Michael Szypula
// Contact : michael.szypula@gmail.com
// License Information : Contact Developer to obtain license agreement.
// =================================================================================================

package bubbletools.ui.main {

	public class Defaults {

		private static var _instance:Defaults = null;
		private var defaultsIndex:Array;

		public static function instance():Defaults {
			if (Defaults._instance == null) {
				Defaults._instance = new Defaults();
			}
			return Defaults._instance;
		}

		public function Defaults() {

			defaultsIndex = new Array();

		}

		public function contains(parameter:String):Boolean {

			if (defaultsIndex[parameter] != undefined) {
				return true;
			} else {
				return false;
			}

		}

		public function add(parameter:String, value:String):void {

			defaultsIndex[parameter] = value;

		}

		public function value(parameter:String):String {

			return (defaultsIndex[parameter]);

		}

	}

}