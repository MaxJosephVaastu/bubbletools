// bubbletools.* ===============================================================================
// BubbleTools™ Web Application and User Interface Component Architecture for Actionscript 3
// ©2007 Michael Szypula.  Any modifications to this file must keep this license block intact.
// Developer : Michael Szypula
// Contact : michael.szypula@gmail.com
// License Information : Contact Developer to obtain license agreement.
// =================================================================================================

package bubbletools.ui.interfaces {
	
	import bubbletools.ui.eventing.UIEvent;

	//	Defines the minimum functions an BTComponent must implement in order to pass actions outside of the UI.
	//	
	//  This interface is designed to be implemented only by BTComponent subclasses which have been assigned
	//  responders to certain events.
	
	public interface Reporter {
	
		//  Creates a UIEvent when requested, which should be forwarded to a responder class that that implements UIControl
	
		function makeEvent(eventType:String):UIEvent;
	
		//	Returns the id of this component
	
		function getId():String;
	}

}