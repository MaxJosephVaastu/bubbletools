﻿// bubbletools.* ===============================================================================// BubbleTools™ Web Application and User Interface Component Architecture for Actionscript 3// ©2007 Michael Szypula.  Any modifications to this file must keep this license block intact.// Developer : Michael Szypula// Contact : michael.szypula@gmail.com// License Information : Contact Developer to obtain license agreement.// =================================================================================================package bubbletools.ui.framework {		import flash.events.MouseEvent;		import flash.display.Sprite;	import bubbletools.util.Pointdata;	import bubbletools.util.MouseEventCapture;	import bubbletools.ui.main.UIMLParams;	import bubbletools.ui.interfaces.IParameters;	import bubbletools.ui.interfaces.Reporter;	import bubbletools.ui.eventing.*	import bubbletools.ui.framework.*	import bubbletools.ui.parameters.*	import bubbletools.ui.framework.ComponentView;	import bubbletools.util.Debug;	public class InterfaceListBox extends InterfaceComponent implements Reporter {		private var parameters:ListBoxParameters;		private var listSelectedId:Number;		private var contentOffset:Pointdata;		private var verticalScrollBar:InterfaceScrollBar;		private var horizontalScrollBar:InterfaceScrollBar;		private var v:ScrollBarParameters;		private var h:ScrollBarParameters;		public function InterfaceListBox(parentComponent:InterfaceComponent) {			super(parentComponent);			componentType = "ListBox";			allowSubcomponents = true;			contentOffset = new Pointdata(0,0);		}		//  =====================================================================================================		//  Reporter Implementation		//		public function makeEvent(eventType:String):UIEvent {			var newEvent:UIEvent = UIEventManager.instance().createUIEvent(id, componentType, eventType);			return(newEvent);		}		//  =====================================================================================================		//  Required Override Methods		//		public override function setParameters(newParameters:IParameters):void {			globalParameters = newParameters;			parameters = ListBoxParameters(newParameters);			checkId();				// Create Scroll bars			if(parameters.getScrollVertical()) {				v = new ScrollBarParameters();				v.setControlDirection("vertical");				v.setScrollTarget(this);				v.setSize(new Pointdata(parameters.getScrollBarSize(), getParameters().getSize().Y));				v.setLocation(new Pointdata(getParameters().getSize().X-parameters.getScrollBarSize(),0));				v.setSliderSize(parameters.getScrollBarSliderSize());				v.setOutline(parameters.getScrollBarOutline());				v.setSliderOutline(parameters.getScrollBarSliderOutline());				if(parameters.getScrollBarImage() != null) {					v.setImage(parameters.getScrollBarImage());				}				if(parameters.getScrollBarSliderImage() != null) {					v.setSliderImage(parameters.getScrollBarSliderImage());				}    								if(parameters.getScrollBarArrows()) {           					v.setArrows(true);   					v.setArrowsClustered(parameters.getScrollBarArrowsClustered());     					v.setArrowMaxDefault(parameters.getScrollBarArrowMaxDefault());					v.setArrowMaxOver(parameters.getScrollBarArrowMaxOver());					v.setArrowMaxDown(parameters.getScrollBarArrowMaxDown());					v.setArrowMinDefault(parameters.getScrollBarArrowMinDefault());					v.setArrowMinOver(parameters.getScrollBarArrowMinOver());					v.setArrowMinDown(parameters.getScrollBarArrowMinDown());   				}  		                         					verticalScrollBar = InterfaceScrollBar(this.addComponent("ScrollBar", v));					}			if(parameters.getScrollHorizontal()) {				h = new ScrollBarParameters();				h.setControlDirection("horizontal");				h.setScrollTarget(this);				h.setSize(new Pointdata(getParameters().getSize().X, parameters.getScrollBarSize()));				h.setLocation(new Pointdata(0, getParameters().getSize().Y-parameters.getScrollBarSize()));				h.setSliderSize(parameters.getScrollBarSliderSize());				h.setOutline(parameters.getScrollBarOutline());				h.setSliderOutline(parameters.getScrollBarSliderOutline());					if(parameters.getScrollBarImage() != null) {					h.setImage(parameters.getScrollBarImage());				}				if(parameters.getScrollBarSliderImage() != null) {					h.setSliderImage(parameters.getScrollBarSliderImage());				} 								if(parameters.getScrollBarArrows()) {					h.setArrows(true);   					h.setArrowsClustered(parameters.getScrollBarArrowsClustered());     					h.setArrowMaxDefault(parameters.getScrollBarArrowMaxDefault());					h.setArrowMaxOver(parameters.getScrollBarArrowMaxOver());					h.setArrowMaxDown(parameters.getScrollBarArrowMaxDown());					h.setArrowMinDefault(parameters.getScrollBarArrowMinDefault());					h.setArrowMinOver(parameters.getScrollBarArrowMinOver());					h.setArrowMinDown(parameters.getScrollBarArrowMinDown());   				}				                         	                    					horizontalScrollBar = InterfaceScrollBar(this.addComponent("ScrollBar", h));				}				if(parameters.getList()) {				var listData:Array = parameters.getList();				var defaults:InterfaceParameters = parameters.getListedParameters();				var paramConstructor:Class = parameters.getListedType().getParameterConstructor();				var listedTypeName:String = parameters.getListedType().getType();				var listedItems:Array = new Array();				for(var i:Number = 0; i<listData.length; i++) {					var mergedXML:XML = defaults.xml().copy();					for(var j:Number = 0; j<listData[i].length; j++) {						mergedXML.insertChildBefore(null, listData[i][j]);					}					//trace(mergedXML);					var p:InterfaceParameters = UIMLParams.instance().createParameters(listedTypeName, getId()+i, mergedXML);					paramConstructor(p).setListId(i);					paramConstructor(p).setVisible(true);					listedItems.push(this.addComponent(listedTypeName, p));				}				parameters.setItemList(listedItems);			}				}		//  The default override displays subcomponents as list.		//  This method only applies to non-dynamic lists, i.e. lists that are predefined in UIML.		//  For lists that load later updateList() is called with a source list.		public override function displayComponent():void {			layoutList();			calculateContentSize();		}		public override function registerInternal(reporter:InterfaceComponent, interfaceEvent:UIEvent):void {						switch (interfaceEvent.info.componentType) {				case "ScrollBar" :					break;				case "Slider" :					break;				case "ListItem" :					switch (interfaceEvent.info.eventType) {						case UIEventType.LIST_ITEM_RELEASE :							if(selectedComponent) {								selectedComponent.deselect();							}							reporter.select();							selectedComponent = reporter;							listSelectedId = InterfaceListItem(reporter).listId();							bubbleEvent(UIEventType.LIST_ITEM_SELECTED);							break;						default:							break;					}				default :					switch (interfaceEvent.info.eventType) {						case UIEventType.LIST_ITEM_RELEASE :							if(selectedComponent) {								selectedComponent.deselect();							}							reporter.select();							selectedComponent = reporter;							listSelectedId = InterfaceComponent(reporter).getParameters().getListId();							bubbleEvent(UIEventType.LISTED_ITEM_SELECTED);							break;						default:							if(selectedComponent) {								selectedComponent.deselect();							}							reporter.select();							selectedComponent = reporter;							listSelectedId = InterfaceComponent(reporter).getParameters().getListId();							bubbleEvent(interfaceEvent.info.eventType);							break;					}								break;			}		}		public override function handleMouseEvent(clickType:String):void {			switch (clickType) {			case "wheel_up" :				mouseWheelScroll();				break;			case "wheel_down" :				mouseWheelScroll();				break;			case "press" :				bubbleEvent(UIEventType.LISTBOX_PRESS);				if (getParameters().getDraggable()) {					startDragging();				}				break;			case "release" :				if (getParameters().getDraggable()) {					stopDragging();				}				break;			case "release_outside" :				if (getParameters().getDraggable()) {					stopDragging();				}				break;			}		}		//  =====================================================================================================		//  Custom Methods		//		public function getSelectedId():Number {			return listSelectedId;		}				public function getSelectedData():String {			return selectedComponent.getParameters().getValue();		}				public function selectItemById(id:Number) {			var selectionId:Number = 0;			for (var i:Number = 0; i<subComponents.length; i++) {				try {					if(getSub(i).listId() == id) {						selectionId = i;						break;					}				} catch(e) {									}			}			if(selectedComponent) {				selectedComponent.deselect();			}			selectedComponent = getSub(selectionId);			getSub(selectionId).select();		}				public function getIdWithValue(val:String):Number {			var id:Number;			var found:Boolean = false			for (var i:Number = 0; i<subComponents.length; i++) {				if(getSub(i).getParameters().getValue() == val) {					id = getSub(i).listId();					break;				}			}			return(id);		}		public function getListedTypeDefaults():InterfaceParameters {			return(parameters.getListedParameters());		}		//  Replaces the list items		public function rebuildList(listInfo:Array):void {			for(var i:Number = 0; i<parameters.getItemList().length; i++) {				// remove components here...			}			updateList(listInfo);		}		//  Adds components to the list from an array of parameters		public function updateList(listInfo:Array):void {				clearList();			parameters.setDataSource(listInfo);			//  Create the components				var listedItems:Array = new Array();				for(var i:Number = 0; i<parameters.getDataSource().length; i++) {				var listItemParams = parameters.getDataSource()[i];				var newListItemConstructor = parameters.getListedType().getConstructor();				var newListItemType = parameters.getListedType().getType();				listedItems.push(this.addComponent(newListItemType, listItemParams));				parameters.setItemList(listedItems);			}			//  Layout in list form			layoutList();			//  Display the components			UI.refreshView();				//  Update the draw depths since we just added new components				//UI.root().updateDrawDepths();				calculateContentSize();		}		public function clearList():void {						var removalList:Array = new Array();						for (var i:Number = 0; i<subComponents.length; i++) {				if(getSub(i).getParameters().getType() == parameters.getListedType().getType()) {					removalList.push(getSub(i).getId());				}			}						for (var r:Number = 0; r<removalList.length; r++) {				UI.component(removalList[r]).removeComponent();			}						calculateContentSize();						setContentOffset(new Pointdata(0,0));				if(parameters.getScrollVertical()) {				verticalScrollBar.resetToZero();			}			if(parameters.getScrollHorizontal()) {				horizontalScrollBar.resetToZero();			}		}		public function layoutList():void {			// Display the list - Vertical			if(parameters.getScrollVertical()) {				var listheight:Number = 1;				for (var i:Number = 0; i<subComponents.length; i++) {					if(getSub(i).getParameters().getType() == parameters.getListedType().getType()) {						getSub(i).getParameters().setLocation(new Pointdata(1, listheight));						listheight += getSub(i).getParameters().getSize().Y;						listheight += parameters.getListSpacing();					}				}			// Display the list - Horizontal			} else if (parameters.getScrollHorizontal()) {				var listwidth:Number = 1;				for (var j:Number = 0; j<subComponents.length; j++) {					if(getSub(j).getParameters().getType() == parameters.getListedType().getType()) {						getSub(j).getParameters().setLocation(new Pointdata(listwidth, 1));						listwidth += getSub(i).getParameters().getSize().X;						listwidth += parameters.getListSpacing();					}				}			}		}		public function setContentOffset(contentOffset:Pointdata):void {			this.contentOffset = contentOffset;		}		public function getContentOffset():Pointdata {			return(contentOffset);		}		public function mouseWheelScroll():void {			if(parameters.getScrollVertical()) {				verticalScrollBar.adjustSlider(0, -mouseEvents.lastEvent.delta);				verticalScrollBar.scrollTargetContents();			}		}	}}