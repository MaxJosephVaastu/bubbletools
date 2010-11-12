// bubbletools.* ===============================================================================
// BubbleTools™ Web Application and User Interface Component Architecture for Actionscript 3
// ©2007 Michael Szypula.  Any modifications to this file must keep this license block intact.
// Developer : Michael Szypula
// Contact : michael.szypula@gmail.com
// License Information : Contact Developer to obtain license agreement.
// =================================================================================================

package bubbletools.ui.interfaces {

	import bubbletools.ui.eventing.UIEvent;

	//
	//	Defines the minimum functions a class which needs to respond to calls from BTComponent subclasses adhering
	//  to the Reporter interface must implement
	//
	public interface UIControl {

		// The user interface communicates to the class via interfaceCall and sends a UIEvent

		function interfaceCall(interfaceEvent:UIEvent):void;
	}

}