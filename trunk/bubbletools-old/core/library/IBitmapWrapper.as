// bubbletools.* ===============================================================================
// BubbleTools™ Web Application and User Interface Component Architecture for Actionscript 3
// ©2007 Michael Szypula.  Any modifications to this file must keep this license block intact.
// Developer : Michael Szypula
// Contact : michael.szypula@gmail.com
// License Information : Contact Developer to obtain license agreement.
// =================================================================================================

package bubbletools.core.library {
	
	import flash.display.BitmapData;

	//	Defines the minimum functions a bitmap wrapper must implement
	
	public interface IBitmapWrapper {

		//  Returns the BitmapData from the wrapper object

		function getBitmapData():BitmapData;
		
		//  Returns whether this is a proxy container (BitmapProxy) or file container (BitmapFile)
		
		function getProxyStatus():Boolean;

	}

}