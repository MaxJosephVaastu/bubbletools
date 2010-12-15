// bubbletools.* ===============================================================================
// BubbleTools™ Web Application and User Interface Component Architecture for Actionscript 3
// ©2007 Michael Szypula.  Any modifications to this file must keep this license block intact.
// Developer : Michael Szypula
// Contact : michael.szypula@gmail.com
// License Information : Contact Developer to obtain license agreement.
// =================================================================================================

package bubbletools.ui.parameters {

	public class TitleBarParameters extends InterfaceParameters {

		private var closeButton:Boolean = false;			//  default option is no close button
		private var closeButtonImage:String;
		private var titleTextFont:String = "Arial";			//  Default is Arial
		private var titleTextFontSize:Number = 12;			//  Default is 12 point font

		public function TitleBarParameters() {
			super();
			componentType = "TitleBar";
			backgroundColor = 0xFFBBBBBB;   				//  default color is grey
			fixedPosition = true;							//  default that titlebars dont get scrolled with content
		}

		// Titlebar Text Font
		public function setTitleTextFont(titleTextFont:String):void {
			this.titleTextFont = titleTextFont;
		}

		public function getTitleTextFont():String {
			return (titleTextFont);
		}

		// Titlebar Text Font Size
		public function setTitleTextFontSize(titleTextFontSize:Number):void {
			this.titleTextFontSize = titleTextFontSize;
		}

		public function getTitleTextFontSize():Number {
			return (titleTextFontSize);
		}

		// Has close button
		public function setCloseButton(closeButton:Boolean):void {
			this.closeButton = closeButton;
		}

		public function getCloseButton():Boolean {
			return (closeButton);
		}

		// Close button image
		public function setCloseButtonImage(closeButtonImage:String):void {
			this.closeButtonImage = closeButtonImage;
		}

		public function getCloseButtonImage():String {
			return closeButtonImage;
		}

	}

}