// bubbletools.* ===============================================================================
// BubbleTools™ Web Application and User Interface Component Architecture for Actionscript 3
// ©2007 Michael Szypula.  Any modifications to this file must keep this license block intact.
// Developer : Michael Szypula
// Contact : michael.szypula@gmail.com
// License Information : Contact Developer to obtain license agreement.
// =================================================================================================

package bubbletools.ui.main {

	import bubbletools.ui.framework.*;
	import bubbletools.ui.main.ComponentType;
	import bubbletools.ui.parameters.*;

	public class AirTypes {

		private static var _instance:AirTypes = null;
		private var typesArray:Array;

		public static function instance():AirTypes {
			if (AirTypes._instance == null) {
				AirTypes._instance = new AirTypes();
			}
			return AirTypes._instance;
		}

		public function AirTypes() {

			ComponentTypes.instance().addCustomComponentType("HTMLDisplay", new ComponentType("HTMLDisplay", BTHTMLDisplay, HTMLDisplayParameters));

		}
	}

}