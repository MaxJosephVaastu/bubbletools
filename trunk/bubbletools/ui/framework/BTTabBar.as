﻿// bubbletools.* ===============================================================================// BubbleTools™ Web Application and User Interface Component Architecture for Actionscript 3// ©2007 Michael Szypula.  Any modifications to this file must keep this license block intact.// Developer : Michael Szypula// Contact : michael.szypula@gmail.com// License Information : Contact Developer to obtain license agreement.// =================================================================================================package bubbletools.ui.framework {	import bubbletools.ui.eventing.*;	import bubbletools.ui.framework.*;	import bubbletools.ui.interfaces.IComponent;	import bubbletools.ui.interfaces.IParameters;	import bubbletools.ui.interfaces.Reporter;	import bubbletools.ui.main.*;	import bubbletools.ui.parameters.*;	import bubbletools.util.Pointdata;	public class BTTabBar extends BTComponent implements Reporter {		private var tabSelectedId:Number; // Id that gets flagged when a tab item is selected		private var parameters:TabBarParameters;		private var tabBarIds:Array;		public function BTTabBar(parentComponent:BTComponent) {			super(parentComponent);			componentType = ComponentTypes.TAB_BAR;			allowSubcomponents = true;		}		//  =====================================================================================================		//  Reporter Implementation		//		public function makeEvent(eventType:String):UIEvent {			var newEvent:UIEvent = UIEventManager.instance().createUIEvent(id, componentType, eventType);			return (newEvent);		}		//  =====================================================================================================		//  Required Override Methods		//		public override function setParameters(newParameters:IParameters):void {			globalParameters = newParameters;			parameters = TabBarParameters(newParameters);			if (parameters.getList()) {				tabBarIds = new Array();				var tabBarData:Array = parameters.getList();				var defaults:InterfaceParameters = parameters.getListedParameters();				var paramConstructor:Class = parameters.getListedType().getParameterConstructor();				var listedTypeName:String = parameters.getListedType().getType();				var listedItems:Array = new Array();				for (var i:Number = 0; i < tabBarData.length; i++) {					var mergedXML:XML = defaults.xml().copy();					for (var j:Number = 0; j < tabBarData[i].length; j++) {						mergedXML.insertChildBefore(null, tabBarData[i][j]);					}					var p:InterfaceParameters = UIMLParams.instance().createParameters(listedTypeName, getId() + i, mergedXML);					paramConstructor(p).setListId(i);					var newTabBarItem:IComponent = IComponent(addComponent(listedTypeName, p));					tabBarIds.push(newTabBarItem.getId());				}			}		}		public override function displayComponent():void {			layoutTabBar();		}		public override function registerInternal(reporter:BTComponent, interfaceEvent:UIEvent):void {			switch (interfaceEvent.info.componentType) {				case "PanelItem":					switch (interfaceEvent.info.eventType) {						case UIEventType.PANEL_ITEM_RELEASE:							if (selectedComponent) {								selectedComponent.deselect();							}							reporter.select();							selectedComponent = reporter;							tabSelectedId = BTPanelItem(reporter).listId();							bubbleEvent(UIEventType.TAB_BAR_ITEM_SELECTED);							break;						case UIEventType.PANEL_ITEM_SELECTED:							if (selectedComponent) {								selectedComponent.deselect();							}							reporter.select();							selectedComponent = reporter;							tabSelectedId = BTPanelItem(reporter).listId();							bubbleEvent(UIEventType.TAB_BAR_ITEM_SELECTED);							break;						default:							break;					}				default:					break;			}		}		public override function handleMouseEvent(clickType:String):void {			switch (clickType) {				case "over":					bubbleEvent(UIEventType.TAB_BAR_OVER);					break;				case "out":					bubbleEvent(UIEventType.TAB_BAR_OUT);					break;				case "press":					bubbleEvent(UIEventType.TAB_BAR_PRESS);					break;				case "release":					bubbleEvent(UIEventType.TAB_BAR_RELEASE);					break;				case "release_outside":					bubbleEvent(UIEventType.TAB_BAR_RELEASE_OUTSIDE);					break;			}		}		//  =====================================================================================================		//  Custom Methods		//		public function getSelectedId():Number {			return tabSelectedId;		}		public function getSelectedData():String {			return selectedComponent.getParameters().getValue();		}		public function getListedTypeDefaults():InterfaceParameters {			return (parameters.getListedParameters());		}		public function forceSelectItem(id:Number):void {			var newSelect:BTComponent = BTUI.component(tabBarIds[id]);			if (selectedComponent) {				selectedComponent.deselect();			}			newSelect.select();			selectedComponent = newSelect;		}		//  Clears list and replaces with a new set of components		public function updateTabBar(tabBarItemParametersList:Array):void {			//  Create the components			tabBarIds = new Array();			for (var i:Number = 0; i < tabBarItemParametersList.length; i++) {				var tabBarItemParams:InterfaceParameters = tabBarItemParametersList[i];				var newTabBarItemConstructor:Class = parameters.getListedType().getConstructor();				var newTabBarItemType:String = parameters.getListedType().getType();				var newTabBarItem:IComponent = IComponent(addComponent(newTabBarItemType, tabBarItemParams));				tabBarIds.push(newTabBarItem.getId());			}			//  Layout in menu form			layoutTabBar();			//  Display the components			BTUI.refreshView();		}		public function layoutTabBar():void {			var tabBarWidth:Number = 0;			for (var i:Number = 0; i < subComponents.length; i++) {				if (getSubcomponentByIndex(i).getParameters().getType() == parameters.getListedType().getType()) {					if (parameters.getTabDirection() == "right") {						getSubcomponentByIndex(i).getParameters().setLocation(new Pointdata(tabBarWidth, 1));					} else if (parameters.getTabDirection() == "left") {						getSubcomponentByIndex(i).getParameters().setLocation(new Pointdata(tabBarWidth, 1));					}					tabBarWidth += getSubcomponentByIndex(i).getParameters().getSize().X;					tabBarWidth += parameters.getTabSpacing();				}			}			//view.updateContainerSize(new Pointdata(tabBarWidth, getParameters().getSize().Y));  			}	}}