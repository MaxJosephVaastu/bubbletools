// bubbletools.* ===============================================================================
// BubbleTools™ Web Application and User Interface Component Architecture for Actionscript 3
// ©2007 Michael Szypula.  Any modifications to this file must keep this license block intact.
// Developer : Michael Szypula
// Contact : michael.szypula@gmail.com
// License Information : Contact Developer to obtain license agreement.
// =================================================================================================

package bubbletools.ui.framework {
	
	import bubbletools.ui.eventing.*;
	import bubbletools.ui.framework.*;
	import bubbletools.ui.interfaces.IContainer;
	import bubbletools.ui.interfaces.IParameters;
	import bubbletools.ui.interfaces.Reporter;
	import bubbletools.ui.parameters.*;
	import bubbletools.util.Debug;
	import bubbletools.util.Pointdata;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.html.HTMLLoader;
	import flash.net.URLRequest;
	
	public class BTHTMLDisplay extends BTComponent implements Reporter, IContainer {

		private var parameters:HTMLDisplayParameters;

		private var verticalScrollBar:BTScrollBar;
		private var horizontalScrollBar:BTScrollBar;
		private var v:ScrollBarParameters;
		private var h:ScrollBarParameters;
		
		private var contentOffset:Pointdata;
		
		private var htmlLoader:HTMLLoader;
		private var htmlRequest:URLRequest;
		
		private var scrollBarWidthOffset:Number = 0;
	
		public function BTHTMLDisplay(parentComponent:BTComponent) {
			super(parentComponent);
			componentType = "HTMLDisplay"; 
			handCursorMode = false;
			allowSubcomponents = true;
			contentOffset = new Pointdata(0,0);
		}
		
		//  =====================================================================================================
		//  Reporter Implementation
		//

		public function makeEvent(eventType:String):UIEvent {
			var newEvent:UIEvent = UIEventManager.instance().createUIEvent(id, componentType, eventType);
			return(newEvent);
		}
	
		//  =====================================================================================================
		//  Required Override Methods
		//
	
		public override function setParameters(newParameters:IParameters):void {
			globalParameters = newParameters;
			parameters = HTMLDisplayParameters(newParameters);
			
			 // Create Scroll Bars
		
			if(parameters.getScrollVertical()) {     

				v = new ScrollBarParameters();
				v.setId(getId()+"_scroll_vertical");
				v.setControlDirection("vertical");
				v.setScrollTarget(this);
				v.setSize(new Pointdata(parameters.getScrollBarSize(), getParameters().getSize().Y));
				v.setLocation(new Pointdata(getParameters().getSize().X-parameters.getScrollBarSize(),0));
				v.setSliderSize(parameters.getScrollBarSliderSize());
				v.setOutline(parameters.getScrollBarOutline());
				v.setSliderOutline(parameters.getScrollBarSliderOutline());
			
				if(parameters.getScrollBarImage() != null) {
					v.setImage(parameters.getScrollBarImage());
				}
				if(parameters.getScrollBarSliderImage() != null) {
					v.setSliderImage(parameters.getScrollBarSliderImage());
				}  
								
				if(parameters.getScrollBarArrows()) {
					v.setArrows(true);   
					v.setArrowsClustered(parameters.getScrollBarArrowsClustered());     
					v.setArrowMaxDefault(parameters.getScrollBarArrowMaxDefault());
					v.setArrowMaxOver(parameters.getScrollBarArrowMaxOver());
					v.setArrowMaxDown(parameters.getScrollBarArrowMaxDown());
					v.setArrowMinDefault(parameters.getScrollBarArrowMinDefault());
					v.setArrowMinOver(parameters.getScrollBarArrowMinOver());
					v.setArrowMinDown(parameters.getScrollBarArrowMinDown());   
				}				       

				verticalScrollBar = BTScrollBar(this.addComponent("ScrollBar", v));
				
				scrollBarWidthOffset = parameters.getScrollBarSize();

			}
			       
			
			if(parameters.getScrollHorizontal()) {
				h = new ScrollBarParameters();
				v.setId(getId()+"_scroll_horizontal");
				h.setControlDirection("horizontal");
				h.setScrollTarget(this);
				h.setSize(new Pointdata(getParameters().getSize().X, parameters.getScrollBarSize()));
				h.setLocation(new Pointdata(0, getParameters().getSize().Y-parameters.getScrollBarSize()));
				h.setOutline(parameters.getScrollBarOutline());
				h.setSliderOutline(parameters.getScrollBarSliderOutline()); 
				
				if(parameters.getScrollBarArrows()) {
					h.setArrows(true);    
					h.setArrowsClustered(parameters.getScrollBarArrowsClustered());    
					h.setArrowMaxDefault(parameters.getScrollBarArrowMaxDefault());
					h.setArrowMaxOver(parameters.getScrollBarArrowMaxOver());
					h.setArrowMaxDown(parameters.getScrollBarArrowMaxDown());
					h.setArrowMinDefault(parameters.getScrollBarArrowMinDefault());
					h.setArrowMinOver(parameters.getScrollBarArrowMinOver());
					h.setArrowMinDown(parameters.getScrollBarArrowMinDown());
				}	 
			
				horizontalScrollBar = BTScrollBar(this.addComponent("ScrollBar", h));

			}
			
			htmlLoader = new HTMLLoader();
			htmlLoader.width = getParameters().getSize().X - scrollBarWidthOffset;
			htmlLoader.height = getParameters().getSize().Y;
			htmlLoader.addEventListener(Event.HTML_BOUNDS_CHANGE, onHtmlBoundsChange);

		}
		
		public override function displayComponent():void {
			//loadPage();
		}
		
		public function loadNewURL(url:String):void {
			parameters.setURL(url);
			loadPage();
		}
		
		public function loadPage():void {
			view.setContents(htmlLoader);
			htmlRequest = new URLRequest(parameters.getURL());
			htmlLoader.load(htmlRequest);
		}
		
		public function clear():void {
			view.clearContents();
		}
	
		//  =====================================================================================================
		//  Custom Methods
		//
		
		public override function resize(W:Number,H:Number):void {
			currentSize = new Pointdata(W,H);
			getParameters().setScaledSize(new Pointdata(W,H));
			view.scale(new Pointdata(W,H));
			propagateResize(W,H);
			
			if(parameters.getScrollVertical()) {              
				verticalScrollBar.setNewPosition(getParameters().getScaledSize().X-parameters.getScrollBarSize(),0);
				verticalScrollBar.resize(parameters.getScrollBarSize(),getParameters().getScaledSize().Y);
			}
			
			if(parameters.getScrollHorizontal()) {
				horizontalScrollBar.resize(getParameters().getSize().X, parameters.getScrollBarSize());
			}      
		}
		
		public function setContentOffset(contentOffset:Pointdata):void {
			this.contentOffset = contentOffset;
		}
		
		public function getContentOffset():Pointdata {
			return(contentOffset);
		}        
		
		public function scrollToPercent(p:Number):void {
			
			var HTMLViewableHeight:Number = htmlLoader.height;
			var HTMLContentHeight:Number = htmlLoader.contentHeight;
			var HTMLScrollRange:Number = Math.max((HTMLContentHeight-HTMLViewableHeight),0);
			var HTMLOffset:Number = p*HTMLScrollRange;
			
			htmlLoader.scrollV = HTMLOffset;
		}
		
		private function onHtmlBoundsChange(event:Event):void {
			bubbleEvent(UIEventType.HTML_SIZE_CHANGED);
		}
		
	}

}
