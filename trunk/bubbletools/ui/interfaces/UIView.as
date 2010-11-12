// bubbletools.* ===============================================================================
// BubbleTools™ Web Application and User Interface Component Architecture for Actionscript 3
// ©2007 Michael Szypula.  Any modifications to this file must keep this license block intact.
// Developer : Michael Szypula
// Contact : michael.szypula@gmail.com
// License Information : Contact Developer to obtain license agreement.
// =================================================================================================

package bubbletools.ui.interfaces {

	public interface UIView {

		//  Called from UIMLView when an invalid UIML file was loaded     
		//  Includes the filename
		function renderFailed(UIML:String):void;

		//  Called from UIMLView when the intial UI has loaded and has started to draw
		function renderStarted():void;

		//  Called from UIMLView when injected XML has loaded and has started to draw
		function renderAdditionalStarted(uiName:String):void;

		//  Called from UIMLView only after it has been notified by applicationReady(),
		//  so the both UI and any other application content are ready.
		function applicationComplete():void;

	}

}