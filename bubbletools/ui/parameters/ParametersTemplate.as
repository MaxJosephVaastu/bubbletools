// bubbletools.* ===============================================================================
// BubbleTools™ Web Application and User Interface Component Architecture for Actionscript 3
// ©2007 Michael Szypula.  Any modifications to this file must keep this license block intact.
// Developer : Michael Szypula
// Contact : michael.szypula@gmail.com
// License Information : Contact Developer to obtain license agreement.
// =================================================================================================

package bubbletools.ui.parameters {

	import bubbletools.ui.parameters.InterfaceParameters;

	public class ParametersTemplate extends InterfaceParameters {

		private var param:String = "template"				// An example parameter

		public function ParametersTemplate() {
			componentType = "Template";						// Use the same name as the component type
			backgroundColor = 0xFFFFFFFF;					// Set default inherited parameters here
		}

		// Describe what the parameter does
		public function setParam(param:String):void {
			this.param = param;
		}

		public function getParam():String {
			return (param);
		}

	}

}

