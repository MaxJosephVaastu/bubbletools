// bubbletools.* ===============================================================================
// BubbleTools™ Web Application and User Interface Component Architecture for Actionscript 3
// ©2007 Michael Szypula.  Any modifications to this file must keep this license block intact.
// Developer : Michael Szypula
// Contact : michael.szypula@gmail.com
// License Information : Contact Developer to obtain license agreement.
// =================================================================================================

package bubbletools.core.library {

	import flash.display.BitmapData;

	public class BitmapCache {

		private static var _instance:BitmapCache = null;
		private var cacheArray:Array;

		public static function instance():BitmapCache {
			if (BitmapCache._instance == null) {
				BitmapCache._instance = new BitmapCache();
			}
			return BitmapCache._instance;
		}

		public function BitmapCache() {
			cacheArray = new Array;
		}

		public function addBitmap(itemName:String, bmp:BitmapData):void {
			cacheArray[itemName] = bmp;
		}

		public function hasBitmap(itemName):Boolean {
			if (cacheArray[itemName] != null) {
				return (true);
			} else {
				return (false);
			}
		}

		public function retrieveBitmap(itemName):BitmapData {
			return (cacheArray[itemName]);
		}
	}

}