// bubbletools.* ===============================================================================
// BubbleTools™ Web Application and User Interface Component Architecture for Actionscript 3
// ©2007 Michael Szypula.  Any modifications to this file must keep this license block intact.
// Developer : Michael Szypula
// Contact : michael.szypula@gmail.com
// License Information : Contact Developer to obtain license agreement.
// =================================================================================================

package bubbletools.ui.parameters {
	
	import bubbletools.ui.framework.BTComponent;
	import bubbletools.ui.parameters.InterfaceParameters;

	public class SlideControlParameters extends InterfaceParameters {
	
		private var controlDirection:String;
		private var sliderOutline:Number = 0;					//default is 0px outline on sliders
		private var sliderImageId:String;
		private var sliderButtonColor:uint = 0xFFFFFFFF;		//default color is white
		private var sliderButtonColorDown:uint = 0xFFCCCCCC;	//default color is grey
		private var sliderSize:Number = 50						//default slider height is 50 px
	
		public function SlideControlParameters(){
			super();
			componentType = "SlideControl";
		}
		// Scrollbar slider size
		public function setSliderSize(sliderSize:Number):void {
			this.sliderSize = sliderSize;
			backgroundColor = 0xFFEEEEEE;   					//default color is light grey
		}
		public function getSliderSize():Number {
			return(sliderSize);
		}
		// Slider outline
		public function setSliderOutline(sliderOutline:Number):void {
			this.sliderOutline = sliderOutline;
		}
		public function getSliderOutline():Number {
			return(sliderOutline);
		}
		// Slider image
		public function setSliderImage(sliderImageId:String):void {
			this.sliderImageId = sliderImageId;
		}
		public function getSliderImage():String {
			return(sliderImageId);
		}
		// Direction of control (vertical or horizontal)
		public function setControlDirection(controlDirection:String):void {
			this.controlDirection = controlDirection;
		}
		public function getControlDirection():String {
			return(controlDirection);
		}
		// Slider Background Color
		public function setSliderButtonColor(sliderButtonColor):void {
			this.sliderButtonColor = sliderButtonColor;
		}
		public function getSliderButtonColor():Number {
			return(sliderButtonColor);
		}
		// Slider Background Down Color
		public function setSliderButtonColorDown(sliderButtonColorDown):void {
			this.sliderButtonColorDown = sliderButtonColorDown;
		}
		public function getSliderButtonColorDown():Number {
			return(sliderButtonColorDown);
		}

	}

}