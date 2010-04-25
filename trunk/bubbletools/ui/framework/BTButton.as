﻿// bubbletools.* ===============================================================================// BubbleTools™ Web Application and User Interface Component Architecture for Actionscript 3// ©2007 Michael Szypula.  Any modifications to this file must keep this license block intact.// Developer : Michael Szypula// Contact : michael.szypula@gmail.com// License Information : Contact Developer to obtain license agreement.// =================================================================================================package bubbletools.ui.framework {	import flash.display.Sprite;	import flash.events.MouseEvent;		import bubbletools.core.eventing.IEvent;		import bubbletools.util.Pointdata;	import bubbletools.util.MouseEventCapture;	import bubbletools.util.Debug;   		import bubbletools.ui.interfaces.Reporter;	import bubbletools.ui.interfaces.IParameters;	import bubbletools.ui.eventing.*	import bubbletools.ui.framework.*	import bubbletools.ui.parameters.*	import bubbletools.ui.framework.ComponentView;	public class BTButton extends BTComponent implements Reporter {			private var parameters:ButtonParameters;		//			private var buttonTextDisplay:BTTextDisplay;		private var buttonTextDisplayParams:TextDisplayParameters;			public function BTButton(parentComponent:BTComponent){			super(parentComponent);			componentType = "Button";			allowSubcomponents = true;			handCursorMode = true;		}			//  =====================================================================================================		//  Reporter Implementation		//		public function makeEvent(eventType:String):UIEvent {			var newEvent:UIEvent = UIEventManager.instance().createUIEvent(id, componentType, eventType);			return(newEvent);		}			//  =====================================================================================================		//  Required Override Methods		//			public override function setParameters(newParameters:IParameters):void {			globalParameters = newParameters;			parameters = ButtonParameters(newParameters);					if(parameters.hasDefault()) {				getParameters().setImage(parameters.imageId())			}					if(parameters.getText() != null) {   				buttonTextDisplayParams = new TextDisplayParameters();				buttonTextDisplayParams.setText(parameters.getText());				buttonTextDisplayParams.setTextColor(getParameters().getTextColor());				buttonTextDisplayParams.setFont(getParameters().getFont());				buttonTextDisplayParams.setFontSize(getParameters().getFontSize());				buttonTextDisplayParams.setTextDisplayBold(getParameters().getTextBold());				buttonTextDisplayParams.setSize(new Pointdata(getParameters().getSize().X, getParameters().getSize().Y));				buttonTextDisplayParams.setLocation(new Pointdata(0,0));				buttonTextDisplayParams.setTextSelectable(false);				buttonTextDisplayParams.setDefaultSize(true);				buttonTextDisplayParams.setTextDisplayVerticalAlign("center");				buttonTextDisplay = BTTextDisplay(this.addComponent("TextDisplay", buttonTextDisplayParams));			}		}				public override function registerInternal(reporter:BTComponent, interfaceEvent:UIEvent):void {			switch(interfaceEvent.info.eventType) {				case UIEventType.TEXT_PRESS :					//bubbleEvent(UIEventType.BUTTON_PRESS);					break;				case UIEventType.TEXT_RELEASE :					//bubbleEvent(UIEventType.BUTTON_RELEASE);					break;				case UIEventType.TEXT_OVER :					handleMouseEvent("over");					break;				case UIEventType.TEXT_OUT :					handleMouseEvent("out");					break;				default :					break;			}		}		//  If a button has a default image, the image is used for all states unless the other states are specified.		//	Otherwise, if there are no images, colors are used for displaying different button states.			public override function handleMouseEvent(clickType:String):void {						switch(clickType) {				case "over" :					updateMouseState("over");					displayOverState();					bubbleEvent(UIEventType.BUTTON_OVER);					if(getMouseState().DRAGGING()) {						bubbleEvent(UIEventType.BUTTON_DRAG_OVER);					}					break;				case "press" :					updateMouseState("down");					displayDownState();					bubbleEvent(UIEventType.BUTTON_PRESS);					if (getParameters().getDraggable()) {						startDragging();					}					if(parameters.getIsToggle()) {						toggleSelected();					}       					break;				case "release" :					updateMouseState("up");					displayDefaultState();					bubbleEvent(UIEventType.BUTTON_RELEASE);					if (getMouseState().DRAGGING()) {						stopDragging();					}					break;				case "release_outside" :					updateMouseState("out");					displayDefaultState();					bubbleEvent(UIEventType.BUTTON_RELEASE_OUTSIDE);					if (getMouseState().DRAGGING()) {						stopDragging();					}					break;					case "out" :					updateMouseState("out");					displayDefaultState();					bubbleEvent(UIEventType.BUTTON_OUT);					if(getMouseState().DRAGGING()) {						bubbleEvent(UIEventType.BUTTON_DRAG_OUT);					}					break;						case "dragout" :					updateMouseState("out");					displayDefaultState();					bubbleEvent(UIEventType.BUTTON_DRAG_OUT);					break;			}		}				//  =====================================================================================================		//  Custom Methods		//				public function updateButtonText(btnText:String):void {			buttonTextDisplay.updateText(btnText);		}  				public function toggleSelected():void {			if(isSelected) {                                				deselect();				bubbleEvent(UIEventType.BUTTON_DESELECTED); 			} else { 				select();   				bubbleEvent(UIEventType.BUTTON_SELECTED);			}		}   				public function displayDefaultState():void {			if(!isSelected) {				if(parameters.hasImages()) {					if(parameters.hasDefault()) {						view.changeImage(parameters.getDefaultState());					}				} else {					view.changeColor(getParameters().getColor());				}			}		}		public function displayDownState():void { 			if(parameters.hasImages()) {				if(parameters.hasDown()) {					view.changeImage(parameters.getDownState());				}			} else {				view.changeColor(getParameters().getColorDown());			}		}		public function displayOverState():void {			if(!isSelected) {				if(parameters.hasImages()) {					if(parameters.hasOver()) {						view.changeImage(parameters.getOverState());					}				} else {					view.changeColor(getParameters().getColorOver());				}			}		}		public override function isDragging(event:MouseEvent):void {			// check to see if mouse has been dragged out of player, if so end the drag event					if(!getMouseState().DRAGGING()) {				stopDragging();			} else {					if(parameters.getDragRestriction() == "horizontal") {										var updateX:Number = Main.instance().mouseX-getParameters().getLocation().X+clickOffset.X;					var parentX = parentComponent.getParameters().getLocation().X;					parentX = 0;					var newX = Main.instance().mouseX+clickOffset.X;					var constraintX:Number;										if(newX < parentX+parameters.getDragPointTopLeft().X) {						constraintX = parentX+parameters.getDragPointTopLeft().X-newX;						updateX += constraintX;					} else if (newX > parentX+parameters.getDragPointBottomRight().X) {						constraintX = newX-(parentX+parameters.getDragPointBottomRight().X);						updateX -= constraintX;					}										updatePosition(updateX, 0);					bubbleEvent(UIEventType.BUTTON_MOVE);									} else if(parameters.getDragRestriction() == "vertical") {										var updateY:Number = Main.instance().mouseY-getParameters().getLocation().Y+clickOffset.Y					var parentY = parentComponent.getParameters().getLocation().Y;					parentY = 0;					var newY = Main.instance().mouseY +clickOffset.Y;					var constraintY:Number;										if(newY < parentY+parameters.getDragPointTopLeft().Y) {						constraintY = parentY+parameters.getDragPointTopLeft().Y-newY;						updateY += constraintY;					} else if (newY > parentY+parameters.getDragPointBottomRight().Y) {						constraintY = newY-(parentY+parameters.getDragPointBottomRight().Y);						updateY -= constraintY;					}					updatePosition(0, updateY);					bubbleEvent(UIEventType.BUTTON_MOVE);									} else {												updatePosition(Main.instance().mouseX-getParameters().getLocation().X+clickOffset.X, Main.instance().mouseY-getParameters().getLocation().Y+clickOffset.Y);								}			}		}	}}