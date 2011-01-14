// bubbletools.* ===============================================================================
// BubbleTools™ Web Application and User Interface Component Architecture for Actionscript 3
// ©2007 Michael Szypula.  Any modifications to this file must keep this license block intact.
// Developer : Michael Szypula
// Contact : michael.szypula@gmail.com
// License Information : Contact Developer to obtain license agreement.
// =================================================================================================       

package bubbletools.filesystem {                                      
	                                             
	import bubbletools.ui.interfaces.IComponent;
	
	public class BTFileView {      
		                                    
		private var file:IFileObject;   
		private var viewComponents:Array;   
		
		public function BTFileView():void {
			                                    
			viewComponents = new Array();
			
		}           
		
		public function createNewView(c:ComponentType):void {
			
		}
		
	}
	
}
		                   