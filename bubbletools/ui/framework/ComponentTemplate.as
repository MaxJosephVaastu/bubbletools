// bubbletools.* ===============================================================================
// BubbleTools™ Web Application and User Interface Component Architecture for Actionscript 3
// ©2007 Michael Szypula.  Any modifications to this file must keep this license block intact.
// Developer : Michael Szypula
// Contact : michael.szypula@gmail.com
// License Information : Contact Developer to obtain license agreement.
// =================================================================================================

package bubbletools.ui.framework {

	import flash.events.MouseEvent;
	import flash.display.Sprite;
	import bubbletools.util.Pointdata;
	import bubbletools.util.MouseEventCapture;
	import bubbletools.ui.eventing.*
	import bubbletools.ui.framework.*
	import bubbletools.ui.parameters.*
	import bubbletools.ui.framework.ComponentView;

	public class BTComponentTemplate extends BTComponent {

		private var parameters:BTComponentParameters;

		public function BTComponentTemplate(parentComponent:BTComponent) {
			super(parentComponent);
			componentType = "Template";
			allowSubcomponents = true;
		}

		//  =====================================================================================================
		//  Required Override Methods
		//

		public override function setParameters(newParameters:IParameters):void {

			globalParameters = newParameters;
			parameters = BTComponentParameters(newParameters);

		}

		public override function displayComponent():void {
			// Extra display commands called after BTComponent.display()
		}

		public override function registerInternal(reporter:BTComponent, interfaceEvent:UIEvent):void {
			// Extra event handling commands called after BTComponent.registerReport()
		}

		public override function handleMouseEvent(clickType:String):void {
			switch (clickType) {
				case "over":
					bubbleEvent("template_over");
					break;
				case "out":
					bubbleEvent("template_out");
					break;
				case "press":
					bubbleEvent("template_press");
					break;
				case "release":
					bubbleEvent("template_release");
					break;
				case "release_outside":
					bubbleEvent("template_release_outside");
					break;
			}
		}

		//  =====================================================================================================
		//  Custom Methods
		//

	}

}
