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
	import bubbletools.ui.parameters.*;
	import bubbletools.util.Pointdata;

	public class BTScrollable extends BTComponent implements IContainer {

		public var parameters:ScrollableParameters;

		private var verticalScrollBar:BTScrollBar;
		private var horizontalScrollBar:BTScrollBar;
		private var v:ScrollBarParameters;
		private var h:ScrollBarParameters;

		private var contentOffset:Pointdata;

		private var scrollBarTotalOffset:Number = 0;

		public function BTScrollable(parentComponent:BTComponent) {
			super(parentComponent);
			componentType = "Scrollable";
			handCursorMode = false;
			allowSubcomponents = true;
			contentOffset = new Pointdata(0, 0);
		}

		//  =====================================================================================================
		//  Required Override Methods
		//

		public override function setParameters(newParameters:IParameters):void {
			globalParameters = newParameters;
			parameters = ScrollableParameters(newParameters);

			// Create Scroll Bars

			if (parameters.getScrollHorizontal() || parameters.getScrollVertical()) {
				scrollBarTotalOffset = parameters.getScrollBarSize() + parameters.getScrollBarOffset();
			}

			if (parameters.getScrollVertical()) {

				v = new ScrollBarParameters();
				v.setId(getId() + "_scroll_vertical");
				v.setControlDirection("vertical");
				v.setScrollTarget(this);
				v.setSize(new Pointdata(parameters.getScrollBarSize(), getParameters().getSize().Y));
				v.setLocation(new Pointdata(getParameters().getSize().X - parameters.getScrollBarSize() + parameters.getScrollBarOffset(), 0));
				v.setSliderSize(parameters.getScrollBarSliderSize());
				v.setOutline(parameters.getScrollBarOutline());
				v.setSliderOutline(parameters.getScrollBarSliderOutline());

				if (parameters.getScrollBarImage() != null) {
					v.setImage(parameters.getScrollBarImage());
				}
				if (parameters.getScrollBarSliderImage() != null) {
					v.setSliderImage(parameters.getScrollBarSliderImage());
				}

				if (parameters.getScrollBarArrows()) {
					v.setArrows(true);
					v.setArrowsClustered(parameters.getScrollBarArrowsClustered());
					v.setArrowMaxDefault(parameters.getScrollBarArrowMaxDefault());
					v.setArrowMaxOver(parameters.getScrollBarArrowMaxOver());
					v.setArrowMaxDown(parameters.getScrollBarArrowMaxDown());
					v.setArrowMinDefault(parameters.getScrollBarArrowMinDefault());
					v.setArrowMinOver(parameters.getScrollBarArrowMinOver());
					v.setArrowMinDown(parameters.getScrollBarArrowMinDown());
				}

				// Adjust overall component size parameters if scrollbar is offset with a gap to the side

				parameters.setSize(new Pointdata(parameters.getSize().X + parameters.getScrollBarOffset(), parameters.getSize().Y));

				verticalScrollBar = BTScrollBar(this.addComponent("ScrollBar", v));

			}

			if (parameters.getScrollHorizontal()) {

				h = new ScrollBarParameters();
				v.setId(getId() + "_scroll_horizontal");
				h.setControlDirection("horizontal");
				h.setScrollTarget(this);
				h.setSize(new Pointdata(getParameters().getSize().X, parameters.getScrollBarSize()));
				h.setLocation(new Pointdata(0, getParameters().getSize().Y - parameters.getScrollBarSize() + parameters.getScrollBarOffset()));
				h.setOutline(parameters.getScrollBarOutline());
				h.setSliderOutline(parameters.getScrollBarSliderOutline());

				if (parameters.getScrollBarArrows()) {
					h.setArrows(true);
					h.setArrowsClustered(parameters.getScrollBarArrowsClustered());
					h.setArrowMaxDefault(parameters.getScrollBarArrowMaxDefault());
					h.setArrowMaxOver(parameters.getScrollBarArrowMaxOver());
					h.setArrowMaxDown(parameters.getScrollBarArrowMaxDown());
					h.setArrowMinDefault(parameters.getScrollBarArrowMinDefault());
					h.setArrowMinOver(parameters.getScrollBarArrowMinOver());
					h.setArrowMinDown(parameters.getScrollBarArrowMinDown());
				}

				// Adjust overall component size parameters if scrollbar is offset with a gap to the side

				parameters.setSize(new Pointdata(parameters.getSize().X, parameters.getSize().Y + parameters.getScrollBarOffset()));

				horizontalScrollBar = BTScrollBar(this.addComponent("ScrollBar", h));

			}

			extendParameters();
		}

		//  =====================================================================================================
		//  Custom Methods
		//

		public override function resize(W:Number, H:Number):void {
			currentSize = new Pointdata(W, H);
			getParameters().setScaledSize(new Pointdata(W, H));
			view.scale(new Pointdata(W, H));
			propagateResize(W, H);

			if (parameters.getScrollVertical()) {
				verticalScrollBar.setNewPosition(getParameters().getScaledSize().X - parameters.getScrollBarSize(), 0);
				verticalScrollBar.resize(parameters.getScrollBarSize(), getParameters().getScaledSize().Y);
			}

			if (parameters.getScrollHorizontal()) {
				horizontalScrollBar.resize(getParameters().getSize().X, parameters.getScrollBarSize());
			}
		}

		public function setContentOffset(contentOffset:Pointdata):void {
			this.contentOffset = contentOffset;
		}

		public function getContentOffset():Pointdata {
			return (contentOffset);
		}

	}

}
