// bubbletools.* ===============================================================================
// BubbleTools™ Web Application and User Interface Component Architecture for Actionscript 3
// ©2007 Michael Szypula.  Any modifications to this file must keep this license block intact.
// Developer : Michael Szypula
// Contact : michael.szypula@gmail.com
// License Information : Contact Developer to obtain license agreement.
// =================================================================================================

package bubbletools.core.library {

	import bubbletools.core.library.BitmapFile;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class BitmapProxy implements IBitmapWrapper {

		private var proxyData:BitmapData;
		private var updates:Array;

		public function BitmapProxy(targetFile:BitmapFile) {
			proxyData = new BitmapData(1, 1, true, 0x00000000);
			updates = new Array();
			targetFile.setProxy(this);
		}

		public function replaceData(targetBitmap:BitmapData):void {
			for (var i:Number = 0; i < updates.length; i++) {
				var w:Number = updates[i].width;
				var h:Number = updates[i].height;
				updates[i].bitmapData = targetBitmap;
				updates[i].smoothing = true;
				updates[i].width = w;
				updates[i].height = h;
			}
			updates = null;
		}

		public function addUpdate(bitmap:Bitmap):void {
			updates.push(bitmap);
		}

		// IBitmapWrapper Implementation

		public function getBitmapDataCopy():BitmapData {

			var newBitmapData:BitmapData = new BitmapData(proxyData.width, proxyData.height, true, 0x00000000);
			var copyFrom:Rectangle = new Rectangle(0, 0, proxyData.width, proxyData.height);
			var copyTo:Point = new Point(0, 0);
			newBitmapData.copyPixels(proxyData, copyFrom, copyTo);

			return (newBitmapData);
		}

		public function getBitmapData():BitmapData {
			return (proxyData);
		}

		public function getProxyStatus():Boolean {
			return (true);
		}

	}

}
