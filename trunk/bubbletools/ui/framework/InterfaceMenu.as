﻿// bubbletools.* ===============================================================================// BubbleTools™ Web Application and User Interface Component Architecture for Actionscript 3// ©2007 Michael Szypula.  Any modifications to this file must keep this license block intact.// Developer : Michael Szypula// Contact : michael.szypula@gmail.com// License Information : Contact Developer to obtain license agreement.// =================================================================================================package bubbletools.ui.framework {	import flash.events.MouseEvent;		import flash.display.Sprite;	import bubbletools.util.Pointdata;	import bubbletools.util.MouseEventCapture;	import bubbletools.ui.interfaces.IParameters;	import bubbletools.ui.interfaces.Reporter;	import bubbletools.ui.eventing.*;	import bubbletools.ui.framework.*;	import bubbletools.ui.parameters.*;	import bubbletools.ui.main.*;	public class InterfaceMenu extends InterfaceComponent implements Reporter {				private var menuSelectedId:Number; 				// Id that gets flagged when a menu item is selected				private var menuShown:Boolean = false;		private var menuDrawn:Boolean = false;		private var menuOpenHeight:Number;		private var menuClosedHeight:Number;				private var parameters:MenuParameters;		private var b:ButtonParameters;				private var menuTitleBar:InterfaceTitleBar;		private var menuHeading:InterfaceButton;		private var menuListBox:InterfaceListBox;			public function InterfaceMenu(parentComponent:InterfaceComponent) {			super(parentComponent);			componentType = "Menu";			allowSubcomponents = true;		}				//  =====================================================================================================		//  Reporter Implementation		//		public function makeEvent(eventType:String):UIEvent {			var newEvent:UIEvent = UIEventManager.instance().createUIEvent(id, componentType, eventType);			return(newEvent);		}			//  =====================================================================================================		//  Required Override Methods		//			public override function setParameters(newParameters:IParameters):void {					globalParameters = newParameters;			parameters = MenuParameters(newParameters);						b = new ButtonParameters();			b.setSize(new Pointdata(parameters.getMenuTitleWidth(), parameters.getMenuTitleHeight()));			b.setText(parameters.getMenuTitle());			b.setTextColor(parameters.getMenuTitleTextColor());			b.setFont(parameters.getMenuTitleFont());			b.setFontSize(parameters.getMenuTitleFontSize());			b.setUseTint(parameters.getUseTint());						if(parameters.getAlignment() == "left") {				b.setLocation(new Pointdata(0,0));			} else if (parameters.getAlignment() == "right") {				b.setLocation(new Pointdata(getParameters().getSize().X-parameters.getMenuTitleWidth(),0));			}						b.setColor(parameters.getColor());			b.setImage(parameters.getMenuTitleImage());			b.setOutline(0);			b.setColorOver(parameters.getColor());			b.setColorDown(parameters.getColor());						menuHeading = InterfaceButton(this.addComponent("Button", b));			menuClosedHeight = parameters.getMenuTitleHeight();						if(parameters.getList()) {								var menuData:Array = parameters.getList();								var defaults:InterfaceParameters = parameters.getListedParameters();				var paramConstructor:Class = parameters.getListedType().getParameterConstructor();				var listedTypeName:String = parameters.getListedType().getType();				var listedItems:Array = new Array();												for(var i:Number = 0; i<menuData.length; i++) {					var mergedXML:XML = defaults.xml().copy();					for(var j:Number = 0; j<menuData[i].length; j++) {						mergedXML.insertChildBefore(null, menuData[i][j]);					}					var p:InterfaceParameters = UIMLParams.instance().createParameters(listedTypeName, getId()+i, mergedXML);					paramConstructor(p).setListId(i);					paramConstructor(p).setVisible(false);					listedItems.push(this.addComponent(listedTypeName, p));				}								parameters.setItemList(listedItems);							}				}				public override function displayComponent():void {						layoutMenu();				}				public override function registerInternal(reporter:InterfaceComponent, interfaceEvent:UIEvent):void {						//trace("register internal on Menu from type: "+interfaceEvent.info.componentType);						switch (interfaceEvent.info.componentType) {				case "Button" :					switch (interfaceEvent.info.eventType) {						case UIEventType.BUTTON_PRESS :							toggleMenu();							break;						default:							break;					}					break;				case "MenuItem" :					switch (interfaceEvent.info.eventType) {						case UIEventType.MENU_ITEM_RELEASE :							if(selectedComponent) {								selectedComponent.deselect();							}							reporter.select();							selectedComponent = reporter;							menuSelectedId = InterfaceMenuItem(reporter).listId();							toggleMenu();							reporter.deselect()							bubbleEvent(UIEventType.MENU_ITEM_SELECTED);							break;						default:							break;					}				default :					break;			}					}		public override function handleMouseEvent(clickType:String):void {			switch (clickType) {				case "over" :					bubbleEvent(UIEventType.MENU_OVER);					break;				case "out" :					bubbleEvent(UIEventType.MENU_OUT);					break;				case "press" :					bubbleEvent(UIEventType.MENU_PRESS);					break;				case "release" :					bubbleEvent(UIEventType.MENU_RELEASE);					break;				case "release_outside" :					bubbleEvent(UIEventType.MENU_RELEASE_OUTSIDE);					break;			}		}				//  =====================================================================================================		//  Additional Overrides		//			public override function show():void {			isVisible = true;			view.showView();			menuHeading.show();		}				//  =====================================================================================================		//  Custom Methods		//				public function getSelectedId():Number {			return menuSelectedId;		}				public function getSelectedData():String {			return selectedComponent.getParameters().getValue();		}				public function toggleMenu():void {			if(menuShown) {				menuShown = false;				hideMenu();			} else {				select();				menuShown = true;				showMenu();			}		}		public function showMenu():void {					if(parameters.getDirection() == "down") {				view.updateContainerSize(new Pointdata(getParameters().getSize().X, menuOpenHeight));			} else if (parameters.getDirection() == "up") {				view.updateContainerSize(new Pointdata(getParameters().getSize().X, menuOpenHeight));				view.offsetView(0, -menuOpenHeight+menuHeading.getParameters().getSize().Y);				menuHeading.updatePosition(0, menuOpenHeight-menuHeading.getParameters().getSize().Y);			}			for (var i:Number = 0; i<subComponents.length; i++) {				getSub(i).getParameters().setVisible(true);			}			showComponents();			bubbleEvent(UIEventType.MENU_SHOW);		}		public function hideMenu():void {			if(parameters.getDirection() == "down") {				view.updateContainerSize(new Pointdata(getParameters().getSize().X, menuClosedHeight));			} else if (parameters.getDirection() == "up") {				view.updateContainerSize(new Pointdata(getParameters().getSize().X, menuClosedHeight));				view.offsetView(0, menuOpenHeight-menuHeading.getParameters().getSize().Y);				menuHeading.updatePosition(0, -menuOpenHeight+menuHeading.getParameters().getSize().Y);			}			hideComponents();			menuHeading.show();			bubbleEvent(UIEventType.MENU_HIDE);		}				public function getListedTypeDefaults():InterfaceParameters {			return(parameters.getListedParameters());		}			//  Adds components to the list from an array of parameters		public function updateMenu(menuInfo:Array):void {			parameters.setDataSource(menuInfo);			//  Create the components			var menuItems:Array = new Array();			for(var i:Number = 0; i<parameters.getDataSource().length; i++) {				var menuItemParams = parameters.getDataSource()[i];				var newMenuItemConstructor = parameters.getListedType().getConstructor();				var newMenuItemType = parameters.getListedType().getType();				menuItems.push(this.addComponent(newMenuItemType, menuItemParams));			}			parameters.setItemList(menuItems);			//  Layout in menu form			layoutMenu();			//  Display the components			UI.refreshView();			hideComponents();			menuHeading.show();		}				public function updateMenuTitle(menuTitle:String):void {						parameters.setMenuTitle(menuTitle);						menuHeading.updateButtonText(menuTitle);				}		public function layoutMenu():void {						var menuHeight:Number = b.getSize().Y;						for (var i:Number = 0; i<subComponents.length; i++) {				if(getSub(i).getParameters().getType() == parameters.getListedType().getType()) {					if(parameters.getDirection() == "down") {						getSub(i).getParameters().setLocation(new Pointdata(1, menuHeight));					} else if (parameters.getDirection() == "up") {						getSub(i).getParameters().setLocation(new Pointdata(1, menuHeight-b.getSize().Y));					}					menuHeight += getSub(i).getParameters().getSize().Y;					menuHeight += parameters.getListSpacing();				}			}						view.updateContainerSize(new Pointdata(getParameters().getSize().X, menuClosedHeight));						menuOpenHeight = menuHeight;						menuHeading.setToTop();								}		}}