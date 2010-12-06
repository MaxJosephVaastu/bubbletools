// bubbletools.* ===============================================================================
// BubbleTools™ Web Application and User Interface Component Architecture for Actionscript 3
// ©2007 Michael Szypula.  Any modifications to this file must keep this license block intact.
// Developer : Michael Szypula
// Contact : michael.szypula@gmail.com
// License Information : Contact Developer to obtain license agreement.
// =================================================================================================

package bubbletools.core.eventing {

	public class EventType {

		public static var MOUSE_PRESS:String = "mouse_press";
		public static var MOUSE_RELEASE:String = "mouse_release";
		public static var MOUSE_OVER:String = "mouse_over";
		public static var MOUSE_OUT:String = "mouse_out";
		public static var MOUSE_DOWN:String = "mouse_down";
		public static var MOUSE_DRAG_OUT:String = "mouse_drag_out";
		public static var MOUSE_RELEASE_OUTSIDE:String = "mouse_release_outside";
		public static var MOUSE_DOUBLE_CLICK:String = "mouse_double_click";
		public static var MOUSE_WHEEL_UP:String = "mouse_wheel_up";
		public static var MOUSE_WHEEL_DOWN:String = "mouse_wheel_down";
		public static var MOUSE_SHIFT_CLICK:String = "mouse_shift_click";
		public static var MOUSE_CONTROL_CLICK:String = "mouse_double_click";

		public static var SPRITE_ANIMATION_COMPLETE:String = "sprite_animation_complete";
		public static var SPRITE_FADEIN_COMPLETE:String = "sprite_fadein_complete";
		public static var SPRITE_FADEOUT_COMPLETE:String = "sprite_fadeout_complete";

		public function EventType() {
		}

	}

}