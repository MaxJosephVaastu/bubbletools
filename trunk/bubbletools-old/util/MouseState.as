// bubbletools.* ===============================================================================
// BubbleTools™ Web Application and User Interface Component Architecture for Actionscript 3
// ©2007 Michael Szypula.  Any modifications to this file must keep this license block intact.
// Developer : Michael Szypula
// Contact : michael.szypula@gmail.com
// License Information : Contact Developer to obtain license agreement.
// =================================================================================================

package bubbletools.util {
	
	// Generic mouse state

	public class MouseState {
	
		private var mouseIsDown:Boolean;
		private var mouseIsOver:Boolean;
		private var isDragging:Boolean;

		public function MouseState(){
			mouseIsDown = false;
			mouseIsOver = false;
			isDragging = false;
		}
		public function update(action:String):void {
			switch(action) {
				case "down" :
					SET_DOWN_STATE(true);
					break;
				case "up" :
					SET_DOWN_STATE(false);
					break;
				case "over" :
					SET_OVER_STATE(true);
					break;
				case "out" :
					SET_OVER_STATE(false);
					break;
				case "drag" :
					SET_DRAG_STATE(true);
					break;
				case "stopdrag" :
					SET_DRAG_STATE(false);
					break;
			}
		}
		public function MOUSE_DOWN():Boolean {
			return(mouseIsDown);
		}
		public function MOUSE_OVER():Boolean {
			return(mouseIsOver);
		}
		public function DRAGGING():Boolean {
			return(isDragging);
		}
	
		public function SET_DOWN_STATE(state:Boolean):void {
			mouseIsDown = state;
		}
		public function SET_OVER_STATE(state:Boolean):void {
			mouseIsOver = state;
		}
		public function SET_DRAG_STATE(state:Boolean):void {
			isDragging = state;
		}
	}
}