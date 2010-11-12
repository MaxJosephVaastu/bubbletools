// bubbletools.* ===============================================================================
// BubbleTools™ Web Application and User Interface Component Architecture for Actionscript 3
// ©2007 Michael Szypula.  Any modifications to this file must keep this license block intact.
// Developer : Michael Szypula
// Contact : michael.szypula@gmail.com
// License Information : Contact Developer to obtain license agreement.
// =================================================================================================

package bubbletools.ui.interfaces {

	import bubbletools.ui.framework.BTComponent;

	//
	//	Defines the minimum functions an interface description class must implement
	//
	public interface UIDescription {

		// Instructions for building the UI

		function defineInterface():void;

		// Returns the root of this UI

		function getInterface():BTComponent;
	}

}