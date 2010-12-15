// bubbletools.* ===============================================================================
// BubbleTools™ Web Application and User Interface Component Architecture for Actionscript 3
// ©2007 Michael Szypula.  Any modifications to this file must keep this license block intact.
// Developer : Michael Szypula
// Contact : michael.szypula@gmail.com
// License Information : Contact Developer to obtain license agreement.
// =================================================================================================

package bubbletools.ui.parameters {

	public class HTMLDisplayParameters extends ScrollableParameters {

		private var url:String;										// the url to display

		public function HTMLDisplayParameters() {
			super();
			componentType = "HTMLDisplay";
			backgroundColor = 0xFFFFFFFF;							// default color is white
			useGlobalTint = false;
		}

		//	External URL for html
		public function setURL(url:String):void {
			this.url = url;
		}

		public function getURL():String {
			return (url);
		}

	}

}

