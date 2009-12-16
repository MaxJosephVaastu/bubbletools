﻿// bubbletools.* ===============================================================================// BubbleTools™ Web Application and User Interface Component Architecture for Actionscript 3// ©2007 Michael Szypula.  Any modifications to this file must keep this license block intact.// Developer : Michael Szypula// Contact : michael.szypula@gmail.com// License Information : Contact Developer to obtain license agreement.// =================================================================================================package bubbletools.ui.framework {	import flash.events.MouseEvent;		import flash.display.Sprite;	import bubbletools.util.Pointdata;	import bubbletools.util.MouseEventCapture;	import bubbletools.ui.interfaces.IParameters;	import bubbletools.ui.interfaces.Reporter;	import bubbletools.ui.eventing.*;	import bubbletools.ui.framework.*;	import bubbletools.ui.parameters.*;	import bubbletools.ui.main.*;	import bubbletools.util.Debug;	public class InterfaceTabBar extends InterfaceComponent implements Reporter {				private var tabSelectedId:Number; 				// Id that gets flagged when a tab item is selected				private var parameters:TabBarParameters;				private var tabListBox:InterfaceListBox;			public function InterfaceTabBar(parentComponent:InterfaceComponent) {			super(parentComponent);			componentType = "TabBar";			allowSubcomponents = true;		}				//  =====================================================================================================		//  Reporter Implementation		//		public function makeEvent(eventType:String):UIEvent {			var newEvent:UIEvent = UIEventManager.instance().createUIEvent(id, componentType, eventType);			return(newEvent);		}			//  =====================================================================================================		//  Required Override Methods		//			public override function setParameters(newParameters:IParameters):void {					globalParameters = newParameters;			parameters = TabBarParameters(newParameters);						if(parameters.getList()) {								var tabBarData:Array = parameters.getList();								var defaults:InterfaceParameters = parameters.getListedParameters();				var paramConstructor:Class = parameters.getListedType().getParameterConstructor();				var listedTypeName:String = parameters.getListedType().getType();				var listedItems:Array = new Array();												for(var i:Number = 0; i<tabBarData.length; i++) {					var mergedXML:XML = defaults.xml().copy();					for(var j:Number = 0; j<tabBarData[i].length; j++) {						mergedXML.insertChildBefore(null, tabBarData[i][j]);					}					var p:InterfaceParameters = UIMLParams.instance().createParameters(listedTypeName, getId()+i, mergedXML);					paramConstructor(p).setListId(i);					listedItems.push(this.addComponent(listedTypeName, p));				}								parameters.setItemList(listedItems);							}				}				public override function displayComponent():void {						layoutTabBar();				}				public override function registerInternal(reporter:InterfaceComponent, interfaceEvent:UIEvent):void {     						switch (interfaceEvent.info.componentType) {				case "PanelItem" :					switch (interfaceEvent.info.eventType) {						case UIEventType.PANEL_ITEM_RELEASE :						   	if(selectedComponent) {								selectedComponent.deselect();							}							reporter.select();							selectedComponent = reporter;							tabSelectedId = InterfacePanelItem(reporter).listId();							bubbleEvent(UIEventType.TAB_BAR_ITEM_SELECTED); 							break; 							 						case UIEventType.PANEL_ITEM_SELECTED :   						   	if(selectedComponent) {								selectedComponent.deselect();							}							reporter.select();							selectedComponent = reporter;							tabSelectedId = InterfacePanelItem(reporter).listId();							bubbleEvent(UIEventType.TAB_BAR_ITEM_SELECTED);     						  	break; 												default:							break;					}				default :					break;			}					}		public override function handleMouseEvent(clickType:String):void {			switch (clickType) {				case "over" :					bubbleEvent(UIEventType.TAB_BAR_OVER);					break;				case "out" :					bubbleEvent(UIEventType.TAB_BAR_OUT);					break;				case "press" :					bubbleEvent(UIEventType.TAB_BAR_PRESS);					break;				case "release" :					bubbleEvent(UIEventType.TAB_BAR_RELEASE);					break;				case "release_outside" :					bubbleEvent(UIEventType.TAB_BAR_RELEASE_OUTSIDE);					break;			}		}				//  =====================================================================================================		//  Custom Methods		//				public function getSelectedId():Number {			return tabSelectedId;		}				public function getSelectedData():String {			return selectedComponent.getParameters().getValue();		}		public function getListedTypeDefaults():InterfaceParameters {			return(parameters.getListedParameters());		}			//  Adds components to the list from an array of parameters		public function updateTabBar(tabBarInfo:Array):void {			parameters.setDataSource(tabBarInfo);			//  Create the components			var tabBarItems:Array = new Array(); 						for(var i:Number = 0; i<parameters.getDataSource().length; i++) {				var tabBarItemParams = parameters.getDataSource()[i];				var newTabBarItemConstructor = parameters.getListedType().getConstructor();				var newTabBarItemType = parameters.getListedType().getType();				tabBarItems.push(this.addComponent(newTabBarItemType, tabBarItemParams));			}         						parameters.setItemList(tabBarItems);			//  Layout in menu form			layoutTabBar();			//  Display the components			UI.refreshView();		}				public function layoutTabBar():void {						var tabBarWidth:Number = 0;						for (var i:Number = 0; i<subComponents.length; i++) {				if(getSub(i).getParameters().getType() == parameters.getListedType().getType()) {					if(parameters.getDirection() == "right") {						getSub(i).getParameters().setLocation(new Pointdata(tabBarWidth, 1));					} else if (parameters.getDirection() == "left") {						getSub(i).getParameters().setLocation(new Pointdata(tabBarWidth, 1));					}					tabBarWidth += getSub(i).getParameters().getSize().X;					tabBarWidth += parameters.getListSpacing();				}			}						//view.updateContainerSize(new Pointdata(tabBarWidth, getParameters().getSize().Y));  						}		}}