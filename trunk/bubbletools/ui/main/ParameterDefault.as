// bubbletools.* ===============================================================================
// BubbleTools™ Web Application and User Interface Component Architecture for Actionscript 3
// ©2007 Michael Szypula.  Any modifications to this file must keep this license block intact.
// Developer : Michael Szypula
// Contact : michael.szypula@gmail.com
// License Information : Contact Developer to obtain license agreement.
// =================================================================================================

package bubbletools.ui.main {

	public class ParameterDefault {

		private var componentType:String;
		private var attributeName:String;
		private var nodeId:String;

		private var _exists:Boolean;

		private var paramTextValue:String;

		public function ParameterDefault(componentType:String, attributeName:String, nodeId:String) {
			this.componentType = componentType;
			this.attributeName = attributeName;
			this.nodeId = nodeId;
		}

		public function applyTextValue(paramTextValue:String):void {
			_exists = true;
			this.paramTextValue = paramTextValue;
		}

		public function getType():String {
			return (componentType);
		}

		public function getAttribute():String {
			return (attributeName);
		}

		public function getNodeId():String {
			return (nodeId);
		}

		public function textValue():String {
			return (paramTextValue);
		}

		public function exists():Boolean {
			return (_exists);
		}

	}

}