// bubbletools.* ===============================================================================
// BubbleTools™ Web Application and User Interface Component Architecture for Actionscript 3
// ©2007 Michael Szypula.  Any modifications to this file must keep this license block intact.
// Developer : Michael Szypula
// Contact : michael.szypula@gmail.com
// License Information : Contact Developer to obtain license agreement.
// =================================================================================================

package bubbletools.core.eventing {
	
import bubbletools.core.eventing.IEvent;

public interface EventsInterface {
	
	function createEvent(name:String, info:Object, EventType:Class):IEvent;

}

}