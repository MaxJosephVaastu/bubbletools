// bubbletools.* ===============================================================================
// BubbleTools™ Web Application and User Interface Component Architecture for Actionscript 3
// ©2007 Michael Szypula.  Any modifications to this file must keep this license block intact.
// Developer : Michael Szypula
// Contact : michael.szypula@gmail.com
// License Information : Contact Developer to obtain license agreement.
// =================================================================================================

package bubbletools.ui.parameters {

	public class ScrollableParameters extends InterfaceParameters {

		private var scrollHorizontal:Boolean;
		private var scrollVertical:Boolean;
		private var scrollBarSize:Number = 20;						//  default size is 20 pixels wide or tall
		private var scrollBarSliderSize:Number = 50					//  default size is 50 pixels wide or tall
		private var scrollBarImageId:String;
		private var scrollBarOutline:Number = 0;
		private var scrollBarSliderOutline:Number = 0;
		private var scrollBarSliderImageId:String;
		private var scrollBarOffset:Number = 0;						//  offset on scrollbar placement (right or bottom)

		private var scrollBarArrows:Boolean = false;	  			//  whether the window's scroll bars have max/min arrows    
		private var scrollBarArrowsClustered:Boolean = false;		//  clustering of scroll bar arrows at bottom or right  
		private var scrollBarArrowMaxDefault:String;
		private var scrollBarArrowMaxOver:String;
		private var scrollBarArrowMaxDown:String;
		private var scrollBarArrowMinDefault:String;
		private var scrollBarArrowMinOver:String;
		private var scrollBarArrowMinDown:String;

		private var draggableByContent:Boolean = false;

		public function ScrollableParameters() {
			super();
			componentType = "Scrollable";
			backgroundColor = 0xFFFFFFFF;							// default color is white
			useGlobalTint = false;
		}

		// Draggable on listed items

		public function setDraggableByContent(draggableByContent:Boolean):void {
			this.draggableByContent = draggableByContent;
		}

		public function getDraggableByContent():Boolean {
			return draggableByContent;
		}

		// Show a vertical scrollbar
		public function setScrollVertical(scrollVertical:Boolean):void {
			this.scrollVertical = scrollVertical;
		}

		public function getScrollVertical():Boolean {
			return (scrollVertical);
		}

		// Show a horizontal scrollbar
		public function setScrollHorizontal(scrollHorizontal:Boolean):void {
			this.scrollHorizontal = scrollHorizontal;
		}

		public function getScrollHorizontal():Boolean {
			return (scrollHorizontal);
		}

		// Scrollbar size
		public function setScrollBarSize(scrollBarSize:Number):void {
			this.scrollBarSize = scrollBarSize;
		}

		public function getScrollBarSize():Number {
			return (scrollBarSize);
		}

		// Scrollbar slider size
		public function setScrollBarSliderSize(scrollBarSliderSize:Number):void {
			this.scrollBarSliderSize = scrollBarSliderSize;
		}

		public function getScrollBarSliderSize():Number {
			return (scrollBarSliderSize);
		}

		// Scrollbar Image
		public function setScrollBarImage(scrollBarImageId:String):void {
			this.scrollBarImageId = scrollBarImageId;
		}

		public function getScrollBarImage():String {
			return (scrollBarImageId)
		}

		// Scrollbar slider Image
		public function setScrollBarSliderImage(scrollBarSliderImageId:String):void {
			this.scrollBarSliderImageId = scrollBarSliderImageId;
		}

		public function getScrollBarSliderImage():String {
			return (scrollBarSliderImageId)
		}

		// Scrollbar slider outline
		public function setScrollBarSliderOutline(scrollBarSliderOutline:Number):void {
			this.scrollBarSliderOutline = scrollBarSliderOutline;
		}

		public function getScrollBarSliderOutline():Number {
			return (scrollBarSliderOutline)
		}

		// Scrollbar outline		
		public function setScrollBarOutline(scrollBarOutline:Number):void {
			this.scrollBarOutline = scrollBarOutline;
		}

		public function getScrollBarOutline():Number {
			return (scrollBarOutline)
		}

		// Has scroll arrows or not
		public function setScrollBarArrows(scrollBarArrows:Boolean):void {
			this.scrollBarArrows = scrollBarArrows;
		}

		public function getScrollBarArrows():Boolean {
			return (scrollBarArrows);
		}

		// Scrollbar arrows cluster or not
		public function setScrollBarArrowsClustered(scrollBarArrowsClustered:Boolean):void {
			this.scrollBarArrowsClustered = scrollBarArrowsClustered;
		}

		public function getScrollBarArrowsClustered():Boolean {
			return (scrollBarArrowsClustered);
		}

		// Scrollbar arrow max default image
		public function setScrollBarArrowMaxDefault(scrollBarArrowMaxDefault:String):void {
			this.scrollBarArrowMaxDefault = scrollBarArrowMaxDefault;
		}

		public function getScrollBarArrowMaxDefault():String {
			return (scrollBarArrowMaxDefault);
		}

		// Scrollbar arrow max over image
		public function setScrollBarArrowMaxOver(scrollBarArrowMaxOver:String):void {
			this.scrollBarArrowMaxOver = scrollBarArrowMaxOver;
		}

		public function getScrollBarArrowMaxOver():String {
			return (scrollBarArrowMaxOver);
		}

		// Scrollbar arrow max down image
		public function setScrollBarArrowMaxDown(scrollBarArrowMaxDown:String):void {
			this.scrollBarArrowMaxDown = scrollBarArrowMaxDown;
		}

		public function getScrollBarArrowMaxDown():String {
			return (scrollBarArrowMaxDown);
		}

		// Scrollbar arrow min default image
		public function setScrollBarArrowMinDefault(scrollBarArrowMinDefault:String):void {
			this.scrollBarArrowMinDefault = scrollBarArrowMinDefault;
		}

		public function getScrollBarArrowMinDefault():String {
			return (scrollBarArrowMinDefault);
		}

		// Scrollbar arrow min over image
		public function setScrollBarArrowMinOver(scrollBarArrowMinOver:String):void {
			this.scrollBarArrowMinOver = scrollBarArrowMinOver;
		}

		public function getScrollBarArrowMinOver():String {
			return (scrollBarArrowMinOver);
		}

		// Scrollbar arrow min down image
		public function setScrollBarArrowMinDown(scrollBarArrowMinDown:String):void {
			this.scrollBarArrowMinDown = scrollBarArrowMinDown;
		}

		public function getScrollBarArrowMinDown():String {
			return (scrollBarArrowMinDown);
		}

		// Scrollbar arrow min down image
		public function setScrollBarOffset(scrollBarOffset:Number):void {
			this.scrollBarOffset = scrollBarOffset;
		}

		public function getScrollBarOffset():Number {
			return (scrollBarOffset);
		}

	}

}

