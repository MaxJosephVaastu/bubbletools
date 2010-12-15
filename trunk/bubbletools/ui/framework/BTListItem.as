﻿// bubbletools.* ===============================================================================// BubbleTools™ Web Application and User Interface Component Architecture for Actionscript 3// ©2007 Michael Szypula.  Any modifications to this file must keep this license block intact.// Developer : Michael Szypula// Contact : michael.szypula@gmail.com// License Information : Contact Developer to obtain license agreement.// =================================================================================================package bubbletools.ui.framework {	import bubbletools.ui.eventing.*;	import bubbletools.ui.framework.*;	import bubbletools.ui.interfaces.IParameters;	import bubbletools.ui.interfaces.Reporter;	import bubbletools.ui.parameters.*;	import bubbletools.util.Pointdata;	public class BTListItem extends BTComponent implements Reporter {		//  =====================================================================================================		//  Component parameters		//		private var parameters:ListItemParameters;		//  =====================================================================================================		// 	Nested components and parameters		//		private var itemText:BTTextDisplay;		private var itemTextParams:TextDisplayParameters;		private var button:BTButton;		private var buttonParams:ButtonParameters;		public function BTListItem(parentComponent:BTComponent) {			super(parentComponent);			componentType = "ListItem";			allowSubcomponents = true;		}		//  =====================================================================================================		//  Reporter Implementation		//		public function makeEvent(eventType:String):UIEvent {			var newEvent:UIEvent = UIEventManager.instance().createUIEvent(id, componentType, eventType);			return (newEvent);		}		//  =====================================================================================================		//  Required Override Methods		//		public override function setParameters(newParameters:IParameters):void {			globalParameters = newParameters;			parameters = ListItemParameters(newParameters);			// Button for the ListItem			buttonParams = new ButtonParameters();			buttonParams.setSize(new Pointdata(getParameters().getSize().X, getParameters().getSize().Y));			buttonParams.setLocation(new Pointdata(0, 0));			//buttonParams.setColor(getParameters().getColor());            			buttonParams.setColor(0x00000000);			buttonParams.setOutline(0);			buttonParams.setColorOver(getParameters().getColorOver());			buttonParams.setColorDown(getParameters().getColorDown());			button = BTButton(this.addComponent("Button", buttonParams));			// Text for the ListItem			itemTextParams = new TextDisplayParameters();			itemTextParams.setText(parameters.getText());			itemTextParams.setSize(getParameters().getSize());			itemTextParams.setTextColor(getParameters().getTextColor());			itemTextParams.setFont(getParameters().getFont());			itemTextParams.setFontSize(getParameters().getFontSize());			itemTextParams.setLocation(new Pointdata(2, 2));			itemTextParams.setTextDisplayAlign("left");			itemTextParams.setTextSelectable(false);			itemText = BTTextDisplay(this.addComponent("TextDisplay", itemTextParams));			//itemText.useParentMask();		}		public override function handleMouseEvent(clickType:String):void {			switch (clickType) {				case "release":					bubbleEvent(UIEventType.LIST_ITEM_RELEASE);					break;			}		}		public override function registerInternal(reporter:BTComponent, interfaceEvent:UIEvent):void {			switch (interfaceEvent.info.eventType) {				case UIEventType.BUTTON_RELEASE:					bubbleEvent(UIEventType.LIST_ITEM_RELEASE);					break;				case UIEventType.TEXT_PRESS:					button.displayDownState();					break;				case UIEventType.TEXT_RELEASE:					bubbleEvent(UIEventType.LIST_ITEM_RELEASE);					break;				case UIEventType.TEXT_OVER:					button.handleMouseEvent("over");					break;				case UIEventType.TEXT_OUT:					button.handleMouseEvent("out");					break;			}		}		public override function select():void {			isSelected = true;			button.select();			button.getView().changeColor(getParameters().getColorDown());		}		public override function deselect():void {			isSelected = false;			button.deselect();			button.handleMouseEvent("out");		}		//  =====================================================================================================		//  Custom Methods		//		public function listId():Number {			return parameters.getListId();		}	}}