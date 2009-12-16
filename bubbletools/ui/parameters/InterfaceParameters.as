﻿// bubbletools.* ===============================================================================// BubbleTools™ Web Application and User Interface Component Architecture for Actionscript 3// ©2007 Michael Szypula.  Any modifications to this file must keep this license block intact.// Developer : Michael Szypula// Contact : michael.szypula@gmail.com// License Information : Contact Developer to obtain license agreement.// =================================================================================================package bubbletools.ui.parameters {	import flash.display.Bitmap;	import flash.display.BitmapData;	import bubbletools.core.library.BitmapFile;	import bubbletools.core.library.BitmapProxy;	import bubbletools.core.library.IBitmapWrapper;	import bubbletools.util.Pointdata;	import bubbletools.ui.interfaces.IParameters;	import bubbletools.ui.framework.UI;	import bubbletools.ui.main.UIMLParams;	import bubbletools.util.Debug;	public class InterfaceParameters implements IParameters {			public var id:String;								//  component ids are set by default on creation, but can be overridden by this id		public var listId:Number = 0;						//  id for this item if it is used in a list		public var dataValue:String;						//  optional UIML-specified value associated with this component		public var list:Array;								//  optional UIML-specified list of parameters, used for populating menus and lists		public var paramXML:XML;		public var visible:Boolean = true;					//  default setting is components are visible		public var componentType:String;		public var componentSize:Pointdata;		public var scaledSize:Pointdata;		public var registrationPoint:Pointdata;		public var isDraggable:Boolean = false;				//  default is not draggable				public var fixedPosition:Boolean = false;			//  default setting is that items will scroll when in a scrollable component		public var hasDropShadow:Boolean = false;			//  default option is to not display a drop shadow		public var backgroundImageId:String;		public var backgroundImage:Bitmap;		public var scaleBackground:Boolean = true;			//  default setting is to scale background image to fit		public var tileBackground:Boolean = false;			//  default setting is no tiling. Setting this to true over rides scale.		public var backgroundScaleType:String = "stretch";		public var useGlobalTint:Boolean = true;			//  default setting is for certain components to apply global tint		public var dragConstraintHorizontal:Pointdata;		public var dragConstraintVertical:Pointdata;		public var backgroundColor:uint = 0xFFDDDDDD;   	//  default color is grey		public var colorOver:Number = 0x330000FF;		public var colorDown:Number = 0x33000055;		public var outline:Number = 1;						//  default setting is outline thickness of 1 pixel		public var outlineColor:uint = 0xFFDDDDDD;			//  default color is black		public var hasTooltip:Boolean = false;				//  default is to not show a tooltip		public var tooltipText:String;				public var itemText:String = "";					//  text		public var itemTextColor:Number = 0xFF000000;		//  text color		public var itemTextFont:String = "Arial";			//  text font		public var itemTextFontSize:Number = 12;			//  text font size  		public var itemTextAlign:String = "left";			//  text alignment		public var itemTextBold:Boolean = false;			//  text bold style			public function InterfaceParameters(){			registrationPoint = new Pointdata(0,0);			//  default setting is 0,0 for item location			componentSize = new Pointdata(0,0);				//  default setting is 0x0 for item size			if(UI._instance) {				outlineColor = UI.outlineColor();			//  default to Theme outline color			}		}		// Saves the XML for these parameters in case we need to clone the object		public function storeXML(paramXML:XML):void {			this.paramXML = paramXML;		}		public function xml():XML {			return(this.paramXML)		}		// Returns a clone of the default UIML parameters for this component		public function clone():InterfaceParameters {			var defaults:InterfaceParameters = UIMLParams.instance().createParameters(componentType, null, paramXML);			return(defaults);		}		public function getType():String {			return(componentType);		}		// Unique Component id		public function setId(id:String):void {			this.id = id;		}		public function getId():String {			return(id);		}		// Numerical id when used in a list		public function setListId(listId:Number):void {			this.listId = listId;		}		public function getListId():Number {			return(listId);		}		// List		public function setList(list:Array):void {			this.list = list;		}		public function getList():Array {			return(list);		}		// Data value		public function setValue(dataValue:String):void {			this.dataValue = dataValue;		}		public function getValue():String {			return(dataValue);		}		// Visibility of component		public function setVisible(visible:Boolean):void {				this.visible = visible;		}		public function getVisible():Boolean {			return(visible);		}		// X and Y of component		public function setLocation(registrationPoint:Pointdata):void {			this.registrationPoint = registrationPoint;		}		public function getLocation():Pointdata {			return(registrationPoint);		}		// Width and Height of component		public function setSize(componentSize:Pointdata):void {				this.componentSize = componentSize;			this.scaledSize = componentSize;		}		public function getSize():Pointdata {			return(componentSize);		}		// Scaled size of component		public function setScaledSize(scaledSize:Pointdata):void {				this.scaledSize = scaledSize;		}		public function getScaledSize():Pointdata {			return(scaledSize);		}		// Item Text		public function setText(itemText:String):void {			if(itemText) {				this.itemText = itemText;			} else {				this.itemText = "";			}		}		public function getText():String {			return(itemText);		}		// Item Text Color		public function setTextColor(itemTextColor:uint):void {			this.itemTextColor = itemTextColor;		}		public function getTextColor():Number {			return(itemTextColor);		}		// Item Text Font		public function setFont(itemTextFont:String):void {			this.itemTextFont = itemTextFont;		}		public function getFont():String {			return(itemTextFont);		}		// Item Text Font Size		public function setFontSize(itemTextFontSize:Number):void {			this.itemTextFontSize = itemTextFontSize;		}		public function getFontSize():Number {			return(itemTextFontSize);		}		// Item Text Boldface		public function setTextBold(itemTextBold:Boolean):void {				this.itemTextBold = itemTextBold;		}		public function getTextBold():Boolean {			return(itemTextBold);		} 		// Item Text Alignment		public function setTextAlign(itemTextAlign):void {			this.itemTextAlign = itemTextAlign;		}		public function getTextAlign():String {			return(itemTextAlign);		}                    		// Whether to display a drop shadow		public function setDropShadow(hasDropShadow:Boolean):void {			this.hasDropShadow = hasDropShadow;		}		public function getDropShadow():Boolean {			return(hasDropShadow);		}		// Whether component uses global tint		public function setUseTint(useGlobalTint:Boolean):void {				this.useGlobalTint = useGlobalTint;		}		public function getUseTint():Boolean {			return(useGlobalTint);		}		// Background color		public function setColor(backgroundColor:uint):void {			this.backgroundColor = backgroundColor;		}		public function getColor():uint {			return(backgroundColor);		}		// Color over		public function setColorOver(colorOver:Number):void {			this.colorOver = colorOver;		}		public function getColorOver():Number {			return(colorOver);		}		// Color down		public function setColorDown(colorDown:Number):void {			this.colorDown = colorDown;		}		public function getColorDown():Number {			return(colorDown);		}		// Outline color		public function setOutlineColor(outlineColor:uint):void {			this.outlineColor = outlineColor;		}		public function getOutlineColor():uint {			return(outlineColor);		}		// Outline thickness around component		public function setOutline(outline:Number):void {			this.outline = outline;		}		public function getOutline():Number {			return(outline);		}		// Component tooltip		public function setTooltipText(tooltipText:String):void {			this.tooltipText = tooltipText;		}		public function getTooltipText():String {			return tooltipText;		}		// Component Background Image		public function setImage(backgroundImageId:String):void {			if(backgroundImageId != null) {				this.backgroundImageId = backgroundImageId;				UI.library().addBitmapFile(new BitmapFile(backgroundImageId, backgroundImageId));			} else {				Debug.output(this, "[WARNING] Attempted to set "+componentType+" background image to NULL");			}		}		public function getBackgroundImage():Bitmap {			if(backgroundImageId != null) {				if(backgroundImage == null) {					backgroundImage = UI.library().requestBitmap(backgroundImageId);					return(backgroundImage);				} else {					return(backgroundImage);				}			} else {				return(null);			}		}		// Scale type (based on scaleBackground and tileBackground)		public function getBackgroundScaleType():String {			return(backgroundScaleType);		}		// Scale background image to fit		public function setScaleBackground(scaleBackground:Boolean):void {			this.scaleBackground = scaleBackground;			if(scaleBackground) {				backgroundScaleType = "stretch";			}		}		public function getScaleBackground():Boolean {			return(scaleBackground);		}		// Tile background image		public function setTileBackground(tileBackground:Boolean):void {			this.tileBackground = tileBackground;			if(tileBackground) {				backgroundScaleType = "tile";			}		}		public function getTileBackground():Boolean {			return(tileBackground);		}		// Drag Constraint - Horizontal		public function setDragConstraintHorizontal(dragConstraintHorizontal:Pointdata):void {			this.dragConstraintHorizontal = dragConstraintHorizontal;		}		public function getDragConstraintHorizontal():Pointdata {			return(dragConstraintHorizontal);		}		// Drag Constraint - Vertical		public function setDragConstraintVertical(dragConstraintVertical:Pointdata):void {			this.dragConstraintVertical = dragConstraintVertical;		}		public function getDragConstraintVertical():Pointdata {			return(dragConstraintVertical);		}		// Locked to fixed position		public function setFixedPosition(fixedPosition:Boolean):void {			this.fixedPosition = fixedPosition;		}		public function getFixedPosition():Boolean {			return(fixedPosition);		}		// allowed to be dragged		public function setDraggable(isDraggable:Boolean):void {			this.isDraggable = isDraggable;		}		public function getDraggable():Boolean {			return(isDraggable);		}	}}