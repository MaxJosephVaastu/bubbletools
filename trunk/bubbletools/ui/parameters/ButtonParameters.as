﻿// bubbletools.* ===============================================================================// BubbleTools™ Web Application and User Interface Component Architecture for Actionscript 3// ©2007 Michael Szypula.  Any modifications to this file must keep this license block intact.// Developer : Michael Szypula// Contact : michael.szypula@gmail.com// License Information : Contact Developer to obtain license agreement.// =================================================================================================package bubbletools.ui.parameters {		import flash.display.BitmapData;	import flash.display.Bitmap;	import bubbletools.core.library.BitmapFile;	import bubbletools.core.library.IBitmapWrapper;	import bubbletools.core.library.BitmapProxy;	import bubbletools.util.Pointdata;	import bubbletools.ui.parameters.InterfaceParameters;	import bubbletools.ui.framework.UI;	import bubbletools.util.Debug;		public class ButtonParameters extends InterfaceParameters {			private var defaultImageId:String;		private var overImageId:String;		private var downImageId:String;			private var defaultImage:Bitmap;		private var overImage:Bitmap;		private var downImage:Bitmap;			private var hasDefaultState:Boolean = false;		// default is no images		private var hasOverState:Boolean = false;			// default is no images		private var hasDownState:Boolean = false;			// default is no images		private var dragPointTopLeft:Pointdata;				// restricted dragging, top left coordinate		private var dragPointBottomRight:Pointdata;			// restricted dragging, bottom left coordinate		private var dragRestriction:String;		private var buttonTextFont:String = "Arial";		// Default is Arial		private var buttonTextFontSize:Number = 12;			// Default is 12 point font		private var buttonTextBold:Boolean = false			// Default is not bold			public function ButtonParameters(){			super();			componentType = "Button";			backgroundColor = 0xFFCCCCFF;					//default color is bluish grey		}		// Images		public function hasDefault():Boolean {			return(hasDefaultState);		}		public function hasOver():Boolean {			return(hasOverState);		}		public function hasDown():Boolean {			return(hasDownState);		}		public function hasImages():Boolean {			return(hasDefaultState || hasOverState || hasDownState)		}		// Returns defaultImageId, used to override and set component backgroundImageId when display is called		public function imageId():String {			return(defaultImageId);		}		// Image states - Button Off		public function setDefaultState(defaultImageId:String):void {			if(defaultImageId != null) {				hasDefaultState = true;				this.defaultImageId = defaultImageId;				UI.library().addBitmapFile(new BitmapFile(defaultImageId, defaultImageId));			} else {				Debug.output(this, "[WARNING] : Attempted to set NULL image for Button Default state");			}		}		public function getDefaultState():Bitmap {			if(defaultImage == null) {				defaultImage = UI.library().requestBitmap(defaultImageId);				return(defaultImage);			} else {				return(defaultImage);			}		}			// Image states - Button Over		public function setOverState(overImageId:String):void {			if(overImageId != null) {				hasOverState = true;				this.overImageId = overImageId;				UI.library().addBitmapFile(new BitmapFile(overImageId, overImageId));			} else {				Debug.output(this, "[WARNING] : Attempted to set NULL image for Button Over state");			}		}		public function getOverState():Bitmap {			if(overImage == null) {				overImage = UI.library().requestBitmap(overImageId);				return(overImage);			} else {				return(overImage);			}		}				// Image states - Button Down		public function setDownState(downImageId:String):void {			if(downImageId != null) {				this.downImageId = downImageId;				UI.library().addBitmapFile(new BitmapFile(downImageId, downImageId));			} else {				Debug.output(this, "[WARNING] : Attempted to set NULL image for Button Down state");			}		}		public function getDownState():Bitmap {			if(downImage == null) {				downImage = UI.library().requestBitmap(downImageId);				return(downImage);			} else {				return(downImage);			}		}							// Top left drag restriction		public function setDragPointTopLeft(dragPointTopLeft:Pointdata):void {			this.dragPointTopLeft = dragPointTopLeft;		}		public function getDragPointTopLeft():Pointdata {			return(dragPointTopLeft);		}		// Bottom right drag restriction		public function setDragPointBottomRight(dragPointBottomRight:Pointdata):void {			this.dragPointBottomRight = dragPointBottomRight;		}		public function getDragPointBottomRight():Pointdata {			return(dragPointBottomRight);		}		// Button Drag constraint direction		public function setDragRestriction(dragRestriction:String):void {			this.dragRestriction = dragRestriction;		}		public function getDragRestriction():String {			return(dragRestriction);		}		// Button Text Bold		public function setButtonTextBold(buttonTextBold:Boolean):void {			this.buttonTextBold = buttonTextBold;		}		public function getButtonTextBold():Boolean {			return(buttonTextBold);		}	}}