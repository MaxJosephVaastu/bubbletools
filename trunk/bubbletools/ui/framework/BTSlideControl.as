﻿// bubbletools.* ===============================================================================// BubbleTools™ Web Application and User Interface Component Architecture for Actionscript 3// ©2007 Michael Szypula.  Any modifications to this file must keep this license block intact.// Developer : Michael Szypula// Contact : michael.szypula@gmail.com// License Information : Contact Developer to obtain license agreement.// =================================================================================================package bubbletools.ui.framework {	import bubbletools.ui.eventing.*;	import bubbletools.ui.framework.*;	import bubbletools.ui.interfaces.IParameters;	import bubbletools.ui.parameters.*;	import bubbletools.util.Pointdata;	public class BTSlideControl extends BTComponent {		public var parameters:SlideControlParameters;		public var controlSlider:BTButton;		public var controlSliderParams:ButtonParameters;		public var controlRange:Number;		public var controlCurrentPosition:Number;		public var controlPercentage:Number;		public var vertical:Boolean = true;		public function BTSlideControl(parentComponent:BTComponent) {			super(parentComponent);			componentType = "SlideControl";			allowSubcomponents = true;		}		//  =====================================================================================================		//  Required Override Methods		//		public override function setParameters(newParameters:IParameters):void {			globalParameters = newParameters;			parameters = SlideControlParameters(newParameters);			controlSliderParams = new ButtonParameters();			controlSliderParams.setColor(parameters.getSliderButtonColor());			controlSliderParams.setColorDown(parameters.getSliderButtonColorDown());			controlSliderParams.setDragRestriction(parameters.getControlDirection());			controlSliderParams.setDraggable(true);			if (parameters.getControlDirection() == "vertical") {				vertical = true;				controlSliderParams.setSize(new Pointdata(getParameters().getSize().X, parameters.getSliderSize()));				controlSliderParams.setDragPointTopLeft(new Pointdata(0, 0));				controlSliderParams.setDragPointBottomRight(new Pointdata(0, getParameters().getSize().Y - parameters.getSliderSize()));				controlSliderParams.setOutline(parameters.getSliderOutline());				controlSliderParams.setDefaultState(parameters.getSliderImage());			} else if (parameters.getControlDirection() == "horizontal") {				vertical = false;				controlSliderParams.setSize(new Pointdata(parameters.getSliderSize(), getParameters().getSize().Y));				controlSliderParams.setDragPointTopLeft(new Pointdata(0, 0));				controlSliderParams.setDragPointBottomRight(new Pointdata(getParameters().getSize().X - parameters.getSliderSize(), 0));				controlSliderParams.setOutline(parameters.getSliderOutline());				controlSliderParams.setDefaultState(parameters.getSliderImage());			}			controlSliderParams.setLocation(new Pointdata(0, 0));			controlSlider = BTButton(this.addComponent("Button", controlSliderParams));			controlSlider.setId("control_slider");			extendParameters();		}		public override function handleMouseEvent(clickType:String):void {			// Do not handle mouse event if slider is being pressed			if (!controlSlider.getMouseState().MOUSE_DOWN()) {				slideControlMouseEvent(clickType);			}		}		public function slideControlMouseEvent(clickType:String):void {			switch (clickType) {				case "press":					controlEventInit();					if (parameters.getControlDirection() == "vertical") {						var sliderY:Number = calculatePosition(BTUI.canvas().mouseY,						getGlobalLocation(null).Y,						controlSlider.getParameters().getScaledSize().Y,						getParameters().getScaledSize().Y);						controlSlider.setNewPosition(0, sliderY);						controlEventComplete();						bubbleEvent(UIEventType.SLIDE_CONTROL_PRESS);					} else if (parameters.getControlDirection() == "horizontal") {						var sliderX:Number = calculatePosition(BTUI.canvas().mouseX,						getGlobalLocation(null).X,						controlSlider.getParameters().getScaledSize().X,						getParameters().getScaledSize().X);						controlSlider.setNewPosition(sliderX, 0);						controlEventComplete();						bubbleEvent(UIEventType.SLIDE_CONTROL_PRESS);					}					break;				case "release":					break;				case "release_outside":					break;				default:					break;			}		}		//  =====================================================================================================		//  Custom Methods		//		public function controlEventInit():void {		}		public function controlEventComplete():void {		}		public function slider():BTButton {			return (controlSlider);		}		public function resetToZero():void {			setToRatio(0);		}		public function setToRatio(r:Number):void {			var position:Number;			if (vertical) {				position = calculatePosition(r * getParameters().getScaledSize().Y,				0,				controlSlider.getParameters().getScaledSize().Y,				getParameters().getScaledSize().Y);				controlSlider.setNewPosition(0, position);			} else {				position = calculatePosition(r * getParameters().getScaledSize().X,				0,				controlSlider.getParameters().getScaledSize().X,				getParameters().getScaledSize().X);				controlSlider.setNewPosition(position, 0);			}		}		public function adjustSlider(x:Number, y:Number):void {			if (vertical) {				var newY:Number = controlSlider.getParameters().getLocation().Y + y;				var sliderParams:ButtonParameters = ButtonParameters(controlSlider.getParameters());				if ((newY > sliderParams.getDragPointTopLeft().Y) && (newY < sliderParams.getDragPointBottomRight().Y)) {					controlSlider.updatePosition(x, y);				}			}		}		public function calculatePosition(mouse:Number, self:Number, sliderSize:Number, controlSize:Number):Number {			var offset:Number = mouse - self;			var sliderSizeOffset:Number = sliderSize / 2;			var sliderPosition:Number = offset - sliderSizeOffset;			if (sliderPosition < 0) {				sliderPosition = 0;			} else if (sliderPosition > (controlSize - sliderSize)) {				sliderPosition = controlSize - sliderSize;			}			return (sliderPosition);		}	}}