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
	import bubbletools.ui.interfaces.Reporter;
	import bubbletools.ui.parameters.*;
	import bubbletools.util.Debug;
	import bubbletools.util.Pointdata;
	
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.html.HTMLLoader;

	public class BTHTMLDisplay extends BTScrollable implements Reporter, IContainer {

		private var extendedParameters:HTMLDisplayParameters;

		private var verticalScrollBar:BTScrollBar;
		private var horizontalScrollBar:BTScrollBar;
		private var v:ScrollBarParameters;
		private var h:ScrollBarParameters;

		private var contentOffset:Pointdata;

		private var htmlLoader:HTMLLoader;
		private var htmlRequest:URLRequest;

		private var scrollBarTotalOffset:Number = 0;

		public function BTHTMLDisplay(parentComponent:BTComponent) {
			super(parentComponent);
			componentType = "HTMLDisplay";
			handCursorMode = false;
			allowSubcomponents = true;
			contentOffset = new Pointdata(0, 0);
		}

		//  =====================================================================================================
		//  Reporter Implementation
		//

		public function makeEvent(eventType:String):UIEvent {
			var newEvent:UIEvent = UIEventManager.instance().createUIEvent(id, componentType, eventType);
			return (newEvent);
		}

		//  =====================================================================================================
		//  Required Override Methods
		//

		// Since this class extends BTScrollable, use extendParameters to set BTHTMLDisplay parmeters

		public override function extendParameters():void {

			extendedParameters = HTMLDisplayParameters(parameters);

			createLoader();

		}

		public override function displayComponent():void {
			Debug.output(this, "displaycomponent");
			loadPage();
		}

		private function createLoader():void {
			htmlLoader = new HTMLLoader();
			htmlLoader.width = getParameters().getSize().X - scrollBarTotalOffset;
			htmlLoader.height = getParameters().getSize().Y;
			htmlLoader.addEventListener(Event.HTML_BOUNDS_CHANGE, onHtmlBoundsChange);
			htmlLoader.addEventListener(Event.COMPLETE, onHtmlComplete);
		}

		public function loadNewURL(url:String):void {
			extendedParameters.setURL(url);
			loadPage();
		}

		public function loadPage():void {

			if (htmlLoader == null) {
				createLoader();
			}

			htmlLoader.visible = false;
			view.setContents(htmlLoader);
			htmlRequest = new URLRequest(extendedParameters.getURL());
			htmlLoader.load(htmlRequest);
		}

		public function clear():void {
			htmlLoader.cancelLoad();
			htmlLoader.visible = false;
			view.clearContents();
		}

		public function blank():void {
			htmlLoader.cancelLoad();
			htmlLoader.visible = false;
			view.clearContents();
			loadNewURL("about:blank");
		}

		//  =====================================================================================================
		//  Custom Methods
		//

		public override function resize(W:Number, H:Number):void {
			currentSize = new Pointdata(W, H);
			getParameters().setScaledSize(new Pointdata(W, H));
			view.scale(new Pointdata(W, H));
			propagateResize(W, H);

			if (extendedParameters.getScrollVertical()) {
				verticalScrollBar.setNewPosition(getParameters().getScaledSize().X - extendedParameters.getScrollBarSize(), 0);
				verticalScrollBar.resize(extendedParameters.getScrollBarSize(), getParameters().getScaledSize().Y);
			}

			if (extendedParameters.getScrollHorizontal()) {
				horizontalScrollBar.resize(getParameters().getSize().X, extendedParameters.getScrollBarSize());
			}
		}

		public function getHTMLLoader():HTMLLoader {
			return htmlLoader;
		}

		public function scrollToPercent(p:Number):void {

			var HTMLViewableHeight:Number = htmlLoader.height;
			var HTMLContentHeight:Number = htmlLoader.contentHeight;
			var HTMLScrollRange:Number = Math.max((HTMLContentHeight - HTMLViewableHeight), 0);
			var HTMLOffset:Number = p * HTMLScrollRange;

			htmlLoader.scrollV = HTMLOffset;
		}

		private function onHtmlBoundsChange(event:Event):void {
			bubbleEvent(UIEventType.HTML_SIZE_CHANGED);
		}

		private function onHtmlComplete(event:Event):void {
			htmlLoader.visible = true;
			bubbleEvent(UIEventType.HTML_COMPLETE);
		}

	}

}
