// bubbletools.* ===============================================================================
// BubbleTools™ Web Application and User Interface Component Architecture for Actionscript 3
// ©2007 Michael Szypula.  Any modifications to this file must keep this license block intact.
// Developer : Michael Szypula
// Contact : michael.szypula@gmail.com
// License Information : Contact Developer to obtain license agreement.
// =================================================================================================

package bubbletools.ui.parameters {
	
	import flash.display.BitmapData;
	import bubbletools.ui.parameters.InterfaceParameters;

	public class VideoDisplayParameters extends InterfaceParameters {
	
		public function VideoDisplayParameters(){
			super();
			componentType = "VideoDisplay";
			setColor(0xFF000000);
			useGlobalTint = false;						// default color is not to tint VideoDisplay
		}
	
	}

}

