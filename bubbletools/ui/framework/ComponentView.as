﻿// bubbletools.* ===============================================================================// BubbleTools™ Web Application and User Interface Component Architecture for Actionscript 3// ©2007 Michael Szypula.  Any modifications to this file must keep this license block intact.// Developer : Michael Szypula// Contact : michael.szypula@gmail.com// License Information : Contact Developer to obtain license agreement.// =================================================================================================package bubbletools.ui.framework {		import bubbletools.ui.framework.BTComponent;	import bubbletools.ui.framework.UI;	import bubbletools.ui.tools.Arrange;	import bubbletools.util.Debug;	import bubbletools.util.Pointdata;	import bubbletools.util.javascript.Javascript;		import flash.display.Bitmap;	import flash.display.BitmapData;	import flash.display.DisplayObject;	import flash.display.Graphics;	import flash.display.Sprite;	import flash.events.TimerEvent;	import flash.filters.DropShadowFilter;	import flash.geom.ColorTransform;	import flash.geom.Point;	import flash.geom.Rectangle;	import flash.utils.Timer;		public class ComponentView extends Sprite {			// main properties			private var fps:Number = 30;  				public var id:String;				private var size:Pointdata;				private var containerSprite:Sprite;			// Sprite to contain background and contents		private var contentSprite:Sprite;			// Sprite to contain content sprites		private var subviewSprite:Sprite;			// Sprite to contain subviews				private var containerMask:Sprite;			// Mask for the container clip		private var containerMaskBitmap:Bitmap;		// Fill for the Mask clip				private var outline:Sprite;					// Outline of the container		private var outlineWidth:Number = 1;		// Outline width		private var outlineColor:uint;		private var fillColor:Number = 0xFFAAAAAA	// Default fill color		                 		private var imgId:String;                   // Background image id		private var maskImgId:String;				// Mask image id (optional)				private var fillerBitmap:Bitmap;			// Background image (assigned or generated as a fill color)				private var filler:BitmapData;				// Data for filler image				private var fillerBitmapImage:Bitmap;       // Local reference to original bitmap data				private var useImgScale:Boolean = false; 	// Applies ONLY to stretch mode		private var backgroundScaleType_str:String;			private var contents:DisplayObject;			// Any content to be added into the contentSprite			private var fadeTimer:Timer;		private var fadeAmount:Number; 		private var fading:Boolean = false;		private var customDropShadowFilter:DropShadowFilter;		public var needsImageData:Boolean = false;				private var tintable:Boolean = false;				public function ComponentView(id:String){			this.id = id;			subviewSprite = new Sprite();		}				public function addSubView(id:String):ComponentView {			if(subviewSprite) {				var newView:ComponentView = ComponentView(subviewSprite.addChild(new ComponentView(id)));			} else {				Debug.output(this, "[ERROR] Missing subview sprite to add ComponentView "+id);			}			return(newView);		}				public function insertView(view:ComponentView):void {			if(subviewSprite) {				subviewSprite.addChild(view);			} else {				Debug.output(this, "[ERROR] Missing subview sprite to insert ComponentView "+id);			}		}				public function addCustomView(customView:Sprite):void {			if(subviewSprite) {				subviewSprite.addChild(customView);			} else {				Debug.output(this, "[ERROR] Missing subview sprite to add customView");			}		}				public function getCustomView():DisplayObject {			if(subviewSprite) {				if(subviewSprite.getChildByName("customView")) {					return subviewSprite.getChildByName("customView");				} else {					Debug.output(this, "[ERROR] Missing customview sprite");					}			} else {				Debug.output(this, "[ERROR] Missing subview sprite");			}			return null;		}				public function removeView(view:ComponentView):void {			if(subviewSprite) {				subviewSprite.removeChild(view);			} else {				Debug.output(this, "[ERROR] Missing subview sprite to remove ComponentView "+id);			}		}		public function getContainer():Sprite {			return containerSprite;		}				public function getSubview():Sprite {			return subviewSprite;		}				public function getComponent():BTComponent {			return UI.component(id);		} 						public function setCustomDropShadowFilter(customDropShadowFilter:DropShadowFilter):void {			this.customDropShadowFilter = customDropShadowFilter;			drawShadow();		}				public function getImageBitmap():Bitmap {			var bmp:Bitmap;  			if(imgId) {								bmp = UI.library().requestBitmap(imgId);								// Apply custom mask if it exists								if(getMaskBitmap() != null) {																Debug.output(this, "getMaskBitmap() returns a value");					var rect:Rectangle = new Rectangle(0, 0, size.X, size.Y);					var pt:Point = new Point(0, 0);					bmp.bitmapData.copyPixels(bmp.bitmapData, rect, pt, getMaskBitmap().bitmapData, pt);				}												return bmp;     		   	} else {				return null;			}                                            		}				public function getMaskBitmap():Bitmap {			var msk:Bitmap;			if(maskImgId) {				msk = UI.library().requestBitmap(maskImgId);				return msk;			} else {				return null;			}		}		   /* 	public function drawView(	coordinates:Pointdata, 									size:Pointdata, 									fillColor:uint, 									imgBitmap:Bitmap,									isVisible:Boolean, 									backgroundScaleType:String):void {  									*/																						public function drawView(	coordinates:Pointdata, 									size:Pointdata, 									fillColor:uint, 									imgId:String,									maskImgId:String,									isVisible:Boolean, 									backgroundScaleType:String):void { 					   this.imgId = imgId;			   this.maskImgId = maskImgId;		    			backgroundScaleType_str = backgroundScaleType;			//Javascript.call("flashAlert", ["view.drawView "+id]);      			//Debug.output(this, "drawView for "+id);   				// Set initial visibility 						this.visible = isVisible;						// Store the view size and color													this.size = size;			this.fillColor = fillColor;   											//  Create container sprite and mask sprite						filler = new BitmapData(size.X, size.Y, true, fillColor);			       			this.x = coordinates.X;			this.y = coordinates.Y;													if(containerSprite == null) {				containerSprite = new Sprite();				this.addChild(containerSprite);			}						if(id != "User_Interface") {				if(containerMask == null) {					containerMask = new Sprite();					containerMaskBitmap = new Bitmap(filler);					containerMask.addChild(containerMaskBitmap);					//containerMask.graphics.beginFill(0xFFFFFF);					//containerMask.graphics.drawRect(0, 0, size.X, size.Y);					///containerMask.graphics.endFill();					this.addChild(containerMask);				}			}						containerSprite.mask = containerMask;									//  Create and add background			if(getImageBitmap() == null) {				// If there is no image data, draw a colored box				fillerBitmap = new Bitmap(filler, "auto", true);			} else {									if(backgroundScaleType == "tile") {										fillerBitmap = createTiled(getImageBitmap());					// Store the image for later use				   // fillerBitmapImage = imgBitmap;									} else {									// Otherwise, use the assigned image data for the background					fillerBitmap = getImageBitmap();									// Store the image for later use								   // fillerBitmapImage = imgBitmap;				}							}			if(backgroundScaleType == "stretch") {				useImgScale = true;				fillerBitmap.width = size.X;				fillerBitmap.height = size.Y;			} else {				Debug.output(this, "ComponentView for "+id+" has backgroundScaleType="+backgroundScaleType);			}						containerSprite.addChild(fillerBitmap);						//  Create sprite for contents						contentSprite = new Sprite();			containerSprite.addChild(contentSprite);						//  Create sprite for subviews						containerSprite.addChild(subviewSprite);					}           				public function createTiled(srcBitmap:Bitmap):Bitmap { 						if((srcBitmap.width == 1) && (srcBitmap.height == 1)) {				needsImageData = true;								return srcBitmap;						} else {					 			var tiledBitmap:Bitmap;									// Create tiling layout									Arrange.Grid(size, srcBitmap.width, srcBitmap.height, 0);			   	//Debug.output(this, "tile size : w="+srcBitmap.width+" h="+srcBitmap.height);				var tiledBitmapData:BitmapData = new BitmapData(size.X, size.Y, false, 0x00000000);				while(Arrange.position) {        					var copyFrom:Rectangle = new Rectangle(0, 0, srcBitmap.width, srcBitmap.height);					var copyToPoint:Pointdata = Arrange.nextPosition();					var copyTo:Point = new Point(copyToPoint.X, copyToPoint.Y);					tiledBitmapData.copyPixels(srcBitmap.bitmapData, copyFrom, copyTo);				}								tiledBitmap = new Bitmap(tiledBitmapData, "auto", true);							return tiledBitmap;				 			}			            		}				public function offsetView(x:Number, y:Number):void {			this.x += x;			this.y += y;		}				public function scale(newSize:Pointdata):void {						updateContainerSize(newSize);							//contentSprite.width = size.X;			//contentSprite.height = size.Y;		}				public function updateContainerSize(size:Pointdata):void {			// Store the view size			this.size = size;      						redrawView();					}				public function redrawView():void {			needsImageData = false;						//  Remove the current mask since we need to replace it			containerSprite.mask = null;                          			if(containerMask) {				if(this.contains(containerMask)) {					this.removeChild(containerMask);				} 			}						//  If the content to draw is larger than 2880x2880, we can't use BitmapData						if((size.X > 2880) || (size.Y > 2880)) {								//Debug.output(this, "using graphics since size is > 2880");				                 				if(containerMask) {					if(containerMask.contains(containerMaskBitmap)) {						containerMask.removeChild(containerMaskBitmap);   					}  					//  Update the filler size									containerMask.graphics.clear();					containerMask.graphics.beginFill(0xFFFFFF);					containerMask.graphics.drawRect(0, 0, size.X, size.Y);					containerMask.graphics.endFill();       				}							} else {														//  Update the filler size							filler = new BitmapData(size.X, size.Y, true, fillColor);         				                         				if(containerMask) {					if(containerMask.contains(containerMaskBitmap)) {						containerMask.removeChild(containerMaskBitmap);					}									containerMaskBitmap = new Bitmap(filler);					containerMask.addChild(containerMaskBitmap);      				}							if(containerSprite.contains(fillerBitmap)) {					containerSprite.removeChild(fillerBitmap);				}							   // if(fillerBitmapImage) {			   if(getImageBitmap()) {   					Debug.output(this, "scaling and using existing image data for "+id);   										 if(backgroundScaleType_str == "tile") {											fillerBitmap = createTiled(getImageBitmap());    										} else {						fillerBitmap = getImageBitmap();					}                                    												} else {										//Debug.output(this, "creating new image background during scale for "+id);										fillerBitmap = new Bitmap(filler, "auto", true);									}				if(useImgScale) {					fillerBitmap.width = size.X;					fillerBitmap.height = size.Y;				}								containerSprite.addChildAt(fillerBitmap,0);									}						// Add the mask back and mask the new size		                               			if(containerMask) {				this.addChildAt(containerMask, 1);				containerSprite.mask = containerMask;			}						// Redraw the outline if needed						if(outline) {				this.removeChild(outline);				drawOutline(outlineWidth, size, outlineColor);			} 		}				public function drawOutline(linewidth:Number, size:Pointdata, color:uint):void {			if(linewidth != 0) {				outlineWidth = linewidth;				outlineColor = color;				outline = new Sprite();				this.addChild(outline);				//outline.graphics.lineStyle(linewidth, UI.outlineColor());				outline.graphics.lineStyle(linewidth, color);				outline.graphics.lineTo(size.X, 0);				outline.graphics.lineTo(size.X, size.Y);				outline.graphics.lineTo(0, size.Y);				outline.graphics.lineTo(0, 0);			}		}		public function destroyOutline():void {			if(containerSprite.contains(outline)) {				containerSprite.removeChild(outline);			}					}		public function applyGlobalTint():void {			tintable = true;			fillerBitmap.transform.colorTransform = UI.tintColor();		}				// Renamed applyShade and removeShade from applyTint and removeTint - adding shadeValue		// Positive values 1 to 255 shade to white, negative -1 to -255 shade to black		public function applyShade(shadeValue:Number):void {			this.transform.colorTransform = new ColorTransform(1,1,1,1,shadeValue,shadeValue,shadeValue,0);		}		public function removeShade():void {			this.transform.colorTransform = new ColorTransform(1,1,1,1,0,0,0,0);		}				public function getShade():Number {			// just need the first shade value since all the values are equal			return(this.transform.colorTransform.redOffset);		}				public function changeColor(newColor:uint):void {			var newColorBmp:BitmapData = new BitmapData(size.X, size.Y, true, newColor);			filler.copyPixels(newColorBmp, new Rectangle(0, 0, newColorBmp.width, newColorBmp.height), new Point(0, 0));			newColorBmp.dispose();		}		public function changeOutlineColor(newColor:uint):void {			destroyOutline();			drawOutline(outlineWidth, size, newColor);		}		public function changeImage(img:Bitmap):void {						// store image						fillerBitmapImage = img;						var w:int;			var h:int;						if(useImgScale) {				w = fillerBitmap.width;				h = fillerBitmap.height;			} else {				w = img.width;				h = img.height;			}						containerSprite.removeChild(fillerBitmap);						fillerBitmap = img;			fillerBitmap.width = w;			fillerBitmap.height = h;						if(tintable) {				applyGlobalTint();			}						containerSprite.addChildAt(fillerBitmap,0);		}		public function centerImage(size:Pointdata):void {			var dw:Number = size.X-fillerBitmap.bitmapData.width;			var dh:Number = size.Y-fillerBitmap.bitmapData.height;			fillerBitmap.x = dw/2;			fillerBitmap.y = dh/2;		}		public function setContents(contents:DisplayObject):void {						//Javascript.call("flashAlert", ["view.setContents in "+id]);							this.contents = contents;			contentSprite.addChild(contents);					}		public function changeContents(replace:DisplayObject):void {			contentSprite.removeChild(contents);			contents = replace;			contentSprite.addChild(contents);		}		public function resizeContents(W:Number, H:Number):void {			contents.height = H;			contents.width = W;			}		public function offsetContents(X:Number, Y:Number):void {			contents.x = X;			contents.y = Y;		}		public function fadeIn(seconds:Number):void { 			fading = true; 			showView();			this.alpha = 0;			fadeAmount = 1/(fps*seconds);			fadeTimer = new Timer(1000/fps, seconds*fps);			fadeTimer.addEventListener("timer", cycleFadeIn);			fadeTimer.addEventListener("timerComplete", endFadeIn);			fadeTimer.start();		}		public function fadeOut(seconds:Number):void {			fading = true;			this.alpha = 1;			fadeAmount = 1/(fps*seconds);			fadeTimer = new Timer(1000/fps, seconds*fps);			fadeTimer.addEventListener("timer", cycleFadeOut);			fadeTimer.addEventListener("timerComplete", endFadeOut);			fadeTimer.start();		}		public function cycleFadeIn(event:TimerEvent):void {    			this.alpha += fadeAmount;		}		public function cycleFadeOut(event:TimerEvent):void {   			this.alpha -= fadeAmount;		}		public function endFadeIn(event:TimerEvent):void {			this.alpha = 1;  			fadeTimer.stop();			fadeTimer = null; 			fading = false;		}		public function endFadeOut(event:TimerEvent):void {			hideView();			this.alpha = 1; 			fadeTimer.stop();			fadeTimer = null;    			fading = false;		}  		public function isFading():Boolean {			return fading;		}		public function drawShadow():void {						var filterArray:Array = new Array();						if(customDropShadowFilter == null) {				var distance:Number = 1;				var angleInDegrees:Number = 90;				var color:Number = 0x000000;				var alpha:Number = .8;				var blurX:Number = 5;				var blurY:Number = 5;				var strength:Number = 1;				var quality:Number = 3;				var inner:Boolean = false;				var knockout:Boolean = false;				var hideObject:Boolean = false;				var filter:DropShadowFilter = new DropShadowFilter(distance, 				                                                    angleInDegrees, 				                                                    color, 				                                                    alpha, 				                                                    blurX, 				                                                    blurY, 				                                                    strength, 				                                                    quality, 				                                                    inner, 				                                                    knockout, 				                                                    hideObject);																					filterArray.push(filter);						} else {				filterArray.push(customDropShadowFilter);			}						this.filters = filterArray;		}		public function setDepth(parentView:ComponentView, newDepth:int):void {			Debug.output(this, "Setting view "+id+" to depth "+newDepth);			parentView.getContainer().setChildIndex(this, newDepth);		}		public function setCoordinates(coordinates:Pointdata):void {			this.x = coordinates.X;			this.y = coordinates.Y;		}		public function scaleContents(viewSize:Pointdata):void {			contentSprite.width = viewSize.X;			contentSprite.height = viewSize.Y;		}		public function scaleView(viewScale:Pointdata):void {			this.scaleX = viewScale.X;			this.scaleY = viewScale.Y;		}		public function showView():void {			this.visible = true;		}		public function hideView():void {			this.visible = false;		}		public function removeContainer():void {			if(this.containerSprite) {				this.removeChild(containerSprite);				containerSprite = null;				this.removeChild(containerMask);				containerMask = null;						} 		}	}}