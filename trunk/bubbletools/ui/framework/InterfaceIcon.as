﻿// bubbletools.* ===============================================================================// BubbleTools™ Web Application and User Interface Component Architecture for Actionscript 3// ©2007 Michael Szypula.  Any modifications to this file must keep this license block intact.// Developer : Michael Szypula// Contact : michael.szypula@gmail.com// License Information : Contact Developer to obtain license agreement.// =================================================================================================package bubbletools.ui.framework {	import flash.events.MouseEvent;	import flash.display.Sprite;	import bubbletools.util.Pointdata;	import bubbletools.util.MouseEventCapture;	import bubbletools.ui.interfaces.Reporter;	import bubbletools.ui.interfaces.IParameters;	import bubbletools.ui.eventing.*	import bubbletools.ui.framework.*	import bubbletools.ui.parameters.*	import bubbletools.ui.framework.ComponentView;	import bubbletools.util.Debug;		public class InterfaceIcon extends InterfaceComponent implements Reporter {			private var parameters:IconParameters;		private var priorParent:InterfaceComponent;			private var iconGraphic:InterfaceWindow;		private var iconGraphicParameters:WindowParameters;		private var iconExternalGraphic:InterfaceImageDisplay;		private var iconExternalGraphicParameters:ImageDisplayParameters;		private var iconTextDisplay:InterfaceTextDisplay;		private var iconTextDisplayParams:TextDisplayParameters;		private var snapX:Number;		private var snapY:Number;			public function InterfaceIcon(parentComponent:InterfaceComponent){			super(parentComponent);			componentType = "Icon";			allowSubcomponents = true; 		}				//  =====================================================================================================		//  Reporter Implementation		//		public function makeEvent(eventType:String):UIEvent {			var newEvent:UIEvent = UIEventManager.instance().createUIEvent(id, componentType, eventType);			return(newEvent);		}			//  =====================================================================================================		//  Required Override Methods		//			public override function setParameters(newParameters:IParameters):void {						globalParameters = newParameters;			parameters = IconParameters(newParameters);						if(parameters.getIcon() != null) {				iconGraphicParameters = new WindowParameters();				iconGraphicParameters.setSize(new Pointdata(getParameters().getSize().X, getParameters().getSize().Y));				iconGraphicParameters.setLocation(new Pointdata(0,0));				iconGraphicParameters.setOutline(0);				iconGraphicParameters.setImage(parameters.getIcon());				iconGraphic = InterfaceWindow(this.addComponent("Window", iconGraphicParameters));			}						if(parameters.getIconExternal() != null) {								iconExternalGraphicParameters = new ImageDisplayParameters();				iconExternalGraphicParameters.setSize(new Pointdata(getParameters().getSize().X, getParameters().getSize().Y));				iconExternalGraphicParameters.setLocation(new Pointdata(0,0));				iconExternalGraphicParameters.setOutline(0);				iconExternalGraphicParameters.setImageURL(parameters.getIconExternal());				iconExternalGraphicParameters.setUseCache(parameters.getUseCache());				iconExternalGraphic = InterfaceImageDisplay(this.addComponent("ImageDisplay", iconExternalGraphicParameters));								trace(iconExternalGraphic);			}						if(getParameters().getText() != null) {								var textFieldHeight:Number = 20;				var textFieldWidth:Number = 100;								// If text is included, expand the width to 100 pixels if the icon is smaller				var maxTextSize:Number = Math.max(getParameters().getSize().X, textFieldWidth);								// Reposition the icon to center the image								var iconImageOffset:Number = 0;				iconImageOffset = (maxTextSize - getParameters().getSize().Y)/2;								if(iconGraphic) {					iconGraphic.updatePosition(iconImageOffset, 0);				} else if (iconExternalGraphic) {					iconExternalGraphic.updatePosition(iconImageOffset, 0);				}							iconTextDisplayParams = new TextDisplayParameters();				iconTextDisplayParams.setText(getParameters().getText());				iconTextDisplayParams.setTextColor(getParameters().getTextColor());				iconTextDisplayParams.setFont(getParameters().getFont());				iconTextDisplayParams.setFontSize(getParameters().getFontSize());				iconTextDisplayParams.setSize(new Pointdata(maxTextSize, textFieldHeight));				iconTextDisplayParams.setLocation(new Pointdata(0,getParameters().getSize().Y));				iconTextDisplayParams.setTextDisplayAlign("center");				iconTextDisplayParams.setTextSelectable(false);				iconTextDisplayParams.setDefaultSize(true);				iconTextDisplay = InterfaceTextDisplay(this.addComponent("TextDisplay", iconTextDisplayParams));								// Resize the icon wrapper to accomodate the textfield								parameters.setSize(new Pointdata(maxTextSize, getParameters().getSize().Y+textFieldHeight));			}					}		public override function handleMouseEvent(clickType:String):void {			switch(clickType) {				case "over" :					updateMouseState("over");					bubbleEvent(UIEventType.ICON_OVER);					break;				case "out" :					updateMouseState("out");					bubbleEvent(UIEventType.ICON_OUT);					break;				case "press" :					updateMouseState("down");					bubbleEvent(UIEventType.ICON_CLICK);					if(getParameters().getDraggable()) {						snapX = getParameters().getLocation().X;						snapY = getParameters().getLocation().Y;						priorParent = InterfaceComponent(parentComponent);						reParent(UI.root());										startDragging();					}					break;				case "release" :					updateMouseState("up");					if(getParameters().getDraggable()) {						stopDragging();						handleDropEvent();						bubbleEvent(UIEventType.ICON_DROP);					}					break;				case "doubleclick" :					Debug.output(this, "ICON DOUBLECLICK");					break;				case "release_outside" :					if(getParameters().getDraggable()) {						stopDragging();						handleDropEvent();						bubbleEvent(UIEventType.ICON_DROP);					}					break;					case "stageout" :					if(getParameters().getDraggable()) {						stopDragging();						reParent(priorParent);						snapBack();						bubbleEvent(UIEventType.ICON_DROP);					}					break;						}		}			//  =====================================================================================================		//  Custom Methods		//			public function handleDropEvent() {						view.startDrag();			view.stopDrag();						if(view.dropTarget.parent.parent is ComponentView) {								var viewDroppedOn:ComponentView = ComponentView(view.dropTarget.parent.parent);				var componentDroppedOn = viewDroppedOn.getComponent();							if(componentDroppedOn.getType() == "Window") {								if(componentDroppedOn.getParameters().getIconDroppable()) {						reParent(componentDroppedOn);					} else {						reParent(priorParent);						snapBack();					}								} else {										reParent(priorParent);					snapBack();								}			} else {				reParent(priorParent);				snapBack();			}		}				public function snapBack():void {			getParameters().setLocation(new Pointdata(snapX, snapY));			updateDraw();		}				public function reverseDrop():void {			reParent(priorParent);			snapBack();		}	}}