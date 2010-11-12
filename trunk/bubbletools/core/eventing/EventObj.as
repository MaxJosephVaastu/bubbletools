// bubbletools.* ===============================================================================
// BubbleTools™ Web Application and User Interface Component Architecture for Actionscript 3
// ©2007 Michael Szypula.  Any modifications to this file must keep this license block intact.
// Developer : Michael Szypula
// Contact : michael.szypula@gmail.com
// License Information : Contact Developer to obtain license agreement.
// =================================================================================================

package bubbletools.core.eventing {

	import bubbletools.core.eventing.IEvent;
	import bubbletools.core.eventing.EventManager;

	public class EventObj implements IEvent {

		public var name:String;
		public var info:Object
		public var id:Number;
		public var type:String;

		public function expire():void {
			EventManager.instance().expireEvent(id);
		}

		public function getType():String {
			return (type);
		}
	}

}