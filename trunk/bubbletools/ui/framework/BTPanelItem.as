﻿// bubbletools.* ===============================================================================// BubbleTools™ Web Application and User Interface Component Architecture for Actionscript 3// ©2007 Michael Szypula.  Any modifications to this file must keep this license block intact.// Developer : Michael Szypula// Contact : michael.szypula@gmail.com// License Information : Contact Developer to obtain license agreement.// =================================================================================================package bubbletools.ui.framework {	import bubbletools.ui.eventing.*;	import bubbletools.ui.framework.*;	import bubbletools.ui.interfaces.IParameters;	import bubbletools.ui.interfaces.Reporter;	import bubbletools.ui.parameters.*;	import bubbletools.util.Debug;	import bubbletools.util.Pointdata;	public class BTPanelItem extends BTComponent implements Reporter {		public static var DESCRIPTION:String = "Layout element containing an loadable image and text element with an overlay button";		//  =====================================================================================================		//  Component parameters		//		private var parameters:PanelItemParameters;		//  =====================================================================================================		// 	Nested components and parameters		//		private var itemText:BTTextDisplay;		private var t:TextDisplayParameters;		private var itemImage:BTImageDisplay;		private var i:ImageDisplayParameters;		private var button:BTButton;		private var b:ButtonParameters;		public function BTPanelItem(parentComponent:BTComponent) {			super(parentComponent);			componentType = "PanelItem";			allowSubcomponents = true;		}		//  =====================================================================================================		//  Reporter Implementation		//		public function makeEvent(eventType:String):UIEvent {			var newEvent:UIEvent = UIEventManager.instance().createUIEvent(id, componentType, eventType);			return (newEvent);		}		//  =====================================================================================================		//  Custom Methods		//		public function itemId():String {			return parameters.getItemId();		}		public function listId():int {			return getParameters().getListId();		}		public function updatePanelImage(URL:String):void {			Debug.output(this, "Update image to " + URL);			itemImage.updateImage(URL);		}		public function updatePanelText(text:String):void {		}		//  =====================================================================================================		//  Required Override Methods		//		public override function setParameters(newParameters:IParameters):void {			globalParameters = newParameters;			parameters = PanelItemParameters(newParameters);			// Image for the PanelItem			i = new ImageDisplayParameters();			i.setSize(new Pointdata(getParameters().getSize().X, getParameters().getSize().Y));			i.setLocation(new Pointdata(0, 0));			i.setOutline(0);			i.setColor(0x00000000);			i.setScaleImage(true);			i.setImageURL("");			itemImage = BTImageDisplay(this.addComponent("ImageDisplay", i));			// Text for the PanelItem			if (parameters.getButtonIsTransparent()) {				// Use TextDisplay component if the button is transparent				t = new TextDisplayParameters();				t.setText(getParameters().getText());				if ((parameters.getPanelTextSize().X != 0) && (parameters.getPanelTextSize().Y != 0)) {					t.setSize(new Pointdata(parameters.getPanelTextSize().X, parameters.getPanelTextSize().Y));				} else {					t.setSize(new Pointdata(getParameters().getSize().X, getParameters().getSize().Y));				}				t.setTextDisplayBold(getParameters().getTextBold());				t.setTextColor(getParameters().getTextColor());				t.setFont(getParameters().getFont());				t.setFontSize(getParameters().getFontSize());				t.setLocation(new Pointdata(parameters.getPanelTextPosition().X, parameters.getPanelTextPosition().Y));				t.setTextDisplayAlign(getParameters().getTextAlign());				t.setTextDisplayVerticalAlign("center");				t.setTextSelectable(false);				itemText = BTTextDisplay(this.addComponent("TextDisplay", t));			}			// Button for the PanelItem			b = new ButtonParameters();			b.setSize(new Pointdata(getParameters().getSize().X, getParameters().getSize().Y));			b.setLocation(new Pointdata(0, 0));			b.setColor(0x00000000);			b.setOutline(0);			b.setColorOver(getParameters().getColorOver());			b.setColorDown(getParameters().getColorDown());			b.setDefaultState(parameters.getButtonDefaultStateId());			b.setOverState(parameters.getButtonOverStateId());			b.setDownState(parameters.getButtonDownStateId());			b.setIsToggle(parameters.getButtonIsToggle());			if (parameters.getButtonIsTransparent() == false) {				// Use the default button text if the button is NOT transparent				b.setText(getParameters().getText());				b.setTextColor(getParameters().getTextColor());				b.setFont(getParameters().getFont());				b.setFontSize(getParameters().getFontSize());			}			button = BTButton(this.addComponent("Button", b));		}		public override function destroyNestedComponents():void {			globalParameters = null;			parameters = null;			t = null;			destroyNestedIfComponentExists(itemText);			itemText = null;			i = null;			destroyNestedIfComponentExists(itemImage);			itemImage = null;			b = null;			destroyNestedIfComponentExists(button);			button = null;		}		public override function handleMouseEvent(clickType:String):void {			switch (clickType) {				case "release":					bubbleEvent(UIEventType.PANEL_ITEM_RELEASE);					break;				case "over":					updateMouseState("over");					bubbleEvent(UIEventType.PANEL_ITEM_OVER);					break;				case "out":					updateMouseState("out");					bubbleEvent(UIEventType.PANEL_ITEM_OUT);					break;				case "press":					updateMouseState("down");					bubbleEvent(UIEventType.PANEL_ITEM_PRESS);					break;			}		}		public override function registerInternal(reporter:BTComponent, interfaceEvent:UIEvent):void {			switch (interfaceEvent.info.eventType) {				case UIEventType.BUTTON_RELEASE:					//bubbleEvent(UIEventType.PANEL_ITEM_RELEASE);					break;				case UIEventType.BUTTON_SELECTED:					if (parentComponent.allowSubselection) {						bubbleEvent(UIEventType.PANEL_ITEM_SELECTED);					} else {						bubbleEvent(UIEventType.PANEL_ITEM_SELECTION_BLOCKED);						deselect();					}					break;				case UIEventType.BUTTON_DESELECTED:					bubbleEvent(UIEventType.PANEL_ITEM_DESELECTED);					break;				default:					break;			}		}		public override function select():void {			isSelected = true;			button.select();			button.displayDownState();		}		public override function deselect():void {			isSelected = false;			button.deselect();			button.displayDefaultState();		}	}}