﻿// bubbletools.* ===============================================================================// BubbleTools™ Web Application and User Interface Component Architecture for Actionscript 3// ©2007 Michael Szypula.  Any modifications to this file must keep this license block intact.// Developer : Michael Szypula// Contact : michael.szypula@gmail.com// License Information : Contact Developer to obtain license agreement.// =================================================================================================package bubbletools.ui.parameters {		import flash.display.Sprite;	import flash.display.BitmapData;	import bubbletools.core.library.BitmapFile;	import bubbletools.util.Pointdata;	import bubbletools.ui.parameters.InterfaceParameters;	import bubbletools.ui.main.ComponentTypes;	import bubbletools.ui.main.ComponentType;	import bubbletools.ui.framework.UI;	import bubbletools.util.Debug;		public class ListBoxParameters extends InterfaceParameters {			private var listedType:ComponentType;		private var listedTypeParameters:InterfaceParameters;			private var itemList:Array;		private var spacing:Number = 0;						//default option is items flush next to each other		private var dataSource:Array;		private var listData:Array;    				private var scrollHorizontal:Boolean = false;		//default option is no horizontal scrollbar		private var scrollVertical:Boolean = true;			//default option is a veritcal scrollbar		private var scrollBarSize:Number = 20;				//default size is 20 pixels wide or tall		private var scrollBarSliderSize:Number = 50			//default size is 50 pixels wide or tall		private var scrollBarImageId:String;		private var scrollBarSliderImageId:String;		private var scrollBarSliderImage:BitmapData;		private var scrollBarImage:BitmapData;		private var scrollBarSliderOutline:Number = 0;		private var scrollBarOutline:Number = 0;  				private var scrollBarArrows:Boolean = false			 		//  whether the listbox's scroll bars have max/min arrows    		private var scrollBarArrowsClustered:Boolean = false;		//  clustering of scroll bar arrows at bottom or right  		private var scrollBarArrowMaxDefault:String; 		private var scrollBarArrowMaxOver:String; 	 		private var scrollBarArrowMaxDown:String;		private var scrollBarArrowMinDefault:String;		private var scrollBarArrowMinOver:String;    		private var scrollBarArrowMinDown:String;  	       			public function ListBoxParameters(){			super();			setListedType("ListItem", new InterfaceParameters());	//  default listed item is a InterfaceListItem			componentType = "ListBox";			backgroundColor = 0xFFDDDDDD;							//  default color is light grey		}		// data source to construct the list		public function setDataSource(dataSource:Array):void {			this.dataSource = dataSource;		}		public function getDataSource():Array {			return(dataSource);		}		// change the type listed in the listbox		public function setListedType(listedTypeName:String, listedTypeParameters:InterfaceParameters):void {			if(ComponentTypes.instance().hasType(listedTypeName)) {				this.listedType = ComponentTypes.instance().getType(listedTypeName);				this.listedTypeParameters = listedTypeParameters;			} else {				Debug.output(this, "WARNING : Listed type for a ListBox does not exist");			}		}		public function getListedType():ComponentType {			return(listedType);		}		public function getListedParameters():InterfaceParameters {			return(listedTypeParameters)		}		// Spacing		public function setListSpacing(spacing:Number):void {			this.spacing = spacing;		}		public function getListSpacing():Number {			return(spacing);		}		// Array for listed components 		public function setItemList(itemList:Array):void {			this.itemList = itemList;		}		public function getItemList():Array {			return(itemList);		}     	  	 // Has scroll arrows or not		public function setScrollBarArrows(scrollBarArrows:Boolean):void {			this.scrollBarArrows = scrollBarArrows;		}		public function getScrollBarArrows():Boolean {			return(scrollBarArrows);		}		// Scrollbar arrows cluster or not		public function setScrollBarArrowsClustered(scrollBarArrowsClustered:Boolean):void {			this.scrollBarArrowsClustered = scrollBarArrowsClustered;		}		public function getScrollBarArrowsClustered():Boolean {			return(scrollBarArrowsClustered);		}         		// Scrollbar arrow max default image		public function setScrollBarArrowMaxDefault(scrollBarArrowMaxDefault:String):void {			this.scrollBarArrowMaxDefault = scrollBarArrowMaxDefault;		}		public function getScrollBarArrowMaxDefault():String {			return(scrollBarArrowMaxDefault);		}		// Scrollbar arrow max over image		public function setScrollBarArrowMaxOver(scrollBarArrowMaxOver:String):void {			this.scrollBarArrowMaxOver = scrollBarArrowMaxOver;		}		public function getScrollBarArrowMaxOver():String {			return(scrollBarArrowMaxOver);		}   	 	// Scrollbar arrow max down image		public function setScrollBarArrowMaxDown(scrollBarArrowMaxDown:String):void {			this.scrollBarArrowMaxDown = scrollBarArrowMaxDown;		}		public function getScrollBarArrowMaxDown():String {			return(scrollBarArrowMaxDown);		}		// Scrollbar arrow min default image		public function setScrollBarArrowMinDefault(scrollBarArrowMinDefault:String):void {			this.scrollBarArrowMinDefault = scrollBarArrowMinDefault;		}		public function getScrollBarArrowMinDefault():String {			return(scrollBarArrowMinDefault);		}		// Scrollbar arrow min over image		public function setScrollBarArrowMinOver(scrollBarArrowMinOver:String):void {			this.scrollBarArrowMinOver = scrollBarArrowMinOver;		}		public function getScrollBarArrowMinOver():String {			return(scrollBarArrowMinOver);		}   	 	// Scrollbar arrow min down image		public function setScrollBarArrowMinDown(scrollBarArrowMinDown:String):void {			this.scrollBarArrowMinDown = scrollBarArrowMinDown;		}		public function getScrollBarArrowMinDown():String {			return(scrollBarArrowMinDown);		}    	              		// Show a vertical scrollbar		public function setScrollVertical(scrollVertical:Boolean):void {			this.scrollVertical = scrollVertical;			this.scrollHorizontal = !(scrollVertical);		}		public function getScrollVertical():Boolean {			return(scrollVertical);		}		// Show a horizontal scrollbar		public function setScrollHorizontal(scrollHorizontal:Boolean):void {			this.scrollHorizontal = scrollHorizontal;			this.scrollVertical = !(scrollHorizontal);		}		public function getScrollHorizontal():Boolean {			return(scrollHorizontal);		}		// Scrollbar size		public function setScrollBarSize(scrollBarSize:Number):void {			this.scrollBarSize = scrollBarSize;		}		public function getScrollBarSize():Number {			return(scrollBarSize);		}		// Scrollbar slider size		public function setScrollBarSliderSize(scrollBarSliderSize:Number):void {			this.scrollBarSliderSize = scrollBarSliderSize;		}		public function getScrollBarSliderSize():Number {			return(scrollBarSliderSize);		}		// Scrollbar Image		public function setScrollBarImage(scrollBarImageId:String):void {			this.scrollBarImageId = scrollBarImageId;		}		public function getScrollBarImage():String {			return(scrollBarImageId)		}		// Scrollbar slider Image		public function setScrollBarSliderImage(scrollBarSliderImageId:String):void {			this.scrollBarSliderImageId = scrollBarSliderImageId;		}		public function getScrollBarSliderImage():String {			return(scrollBarSliderImageId)		}		// Scrollbar outline				public function setScrollBarOutline(scrollBarOutline:Number):void {			this.scrollBarOutline = scrollBarOutline;		}		public function getScrollBarOutline():Number {			return(scrollBarOutline)		}		// Scrollbar slider outline		public function setScrollBarSliderOutline(scrollBarSliderOutline:Number):void {			this.scrollBarSliderOutline = scrollBarSliderOutline;		}		public function getScrollBarSliderOutline():Number {			return(scrollBarSliderOutline)		}	}}