﻿// bubbletools.* ===============================================================================// BubbleTools™ Web Application and User Interface Component Architecture for Actionscript 3// ©2007 Michael Szypula.  Any modifications to this file must keep this license block intact.// Developer : Michael Szypula// Contact : michael.szypula@gmail.com// License Information : Contact Developer to obtain license agreement.// =================================================================================================package bubbletools.ui.main {		public class ParameterBindingList {			import bubbletools.ui.main.ParameterBinding;		import bubbletools.ui.parameters.*;			private static var _instance:ParameterBindingList = null;		private var bindings:Array;			public static function instance():ParameterBindingList {			if (ParameterBindingList._instance == null) {				ParameterBindingList._instance = new ParameterBindingList();			}			return ParameterBindingList._instance;		}		public function ParameterBindingList(){					// Set up the default parameter bindings for all base components.			// More bindings may be added per-application using the addCustomBinding method.			//			// Note : Type "Abstract" is used for bindings that affect all components.  			// Any parameters stored as "Abstract" will be bound to any custom components that are added as well.					bindings = new Array();						// Global bindings			bindings.push(new ParameterBinding("Abstract", "setSize", "Width", "Pointdata", true));				bindings.push(new ParameterBinding("Abstract", "setSize", "Height", "Pointdata", true));			bindings.push(new ParameterBinding("Abstract", "setLocation", "PositionX", "Pointdata", true));			bindings.push(new ParameterBinding("Abstract", "setLocation", "PositionY", "Pointdata", true));			bindings.push(new ParameterBinding("Abstract", "setImage", "Image", "String", false));			bindings.push(new ParameterBinding("Abstract", "setColor", "Color", "Number", false));			bindings.push(new ParameterBinding("Abstract", "setOutline", "Outline", "Number", false));			bindings.push(new ParameterBinding("Abstract", "setUseTint", "Tint", "Boolean", false));			bindings.push(new ParameterBinding("Abstract", "setDropShadow", "DropShadow", "Boolean", false));			bindings.push(new ParameterBinding("Abstract", "setOutlineColor", "OutlineColor", "Number", false));			bindings.push(new ParameterBinding("Abstract", "setList", "List", "Data", false));			bindings.push(new ParameterBinding("Abstract", "setValue", "Data", "String", false));			bindings.push(new ParameterBinding("Abstract", "setColorOver", "ColorOver", "String", false));			bindings.push(new ParameterBinding("Abstract", "setColorDown", "ColorDown", "String", false));			bindings.push(new ParameterBinding("Abstract", "setScaleBackground", "ScaleBackground", "Boolean", false));			bindings.push(new ParameterBinding("Abstract", "setTileBackground", "TileBackground", "Boolean", false));			// Inheritable by any components which need to set nested TextDisplay parameters			bindings.push(new ParameterBinding("Abstract", "setText", "Text", "String", false));			bindings.push(new ParameterBinding("Abstract", "setTextColor", "TextColor", "Number", false));    			bindings.push(new ParameterBinding("Abstract", "setTextBold", "Bold", "Boolean", false)); 			bindings.push(new ParameterBinding("Abstract", "setTextAlign", "TextAlign", "String", false));   			bindings.push(new ParameterBinding("Abstract", "setVisible", "Visible", "Boolean", false));			bindings.push(new ParameterBinding("Abstract", "setFont", "Font", "String", false));			bindings.push(new ParameterBinding("Abstract", "setFontSize", "FontSize", "Number", false));         			// Window Bindings			bindings.push(new ParameterBinding("Window", "setStack", "Stack", "Boolean", false));			bindings.push(new ParameterBinding("Window", "setDraggable", "Draggable", "Boolean", false));    			bindings.push(new ParameterBinding("Window", "setDirectDrag", "DirectDrag", "Boolean", false));    			bindings.push(new ParameterBinding("Window", "setIconDroppable", "IconDroppable", "Boolean", false));			bindings.push(new ParameterBinding("Window", "setTitleBar", "TitleBar", "Boolean", false));			bindings.push(new ParameterBinding("Window", "setTitleBarSize", "TitleBarSize", "Number", false));			bindings.push(new ParameterBinding("Window", "setTitleText", "TitleText", "String", false));			bindings.push(new ParameterBinding("Window", "setTitleTextColor", "TitleTextColor", "Number", false));			bindings.push(new ParameterBinding("Window", "setTitleTextFont", "TitleFont", "String", false));			bindings.push(new ParameterBinding("Window", "setTitleTextFontSize", "TitleFontSize", "Number", false));				bindings.push(new ParameterBinding("Window", "setTitleBarBackground", "TitleBarBackground", "String", false));			bindings.push(new ParameterBinding("Window", "setCloseButton", "CloseButton", "Boolean", false));			bindings.push(new ParameterBinding("Window", "setCloseButtonImage", "CloseButtonImage", "String", false));			bindings.push(new ParameterBinding("Window", "setScrollVertical", "ScrollVertical", "Boolean", false));			bindings.push(new ParameterBinding("Window", "setScrollHorizontal", "ScrollHorizontal", "Boolean", false));			bindings.push(new ParameterBinding("Window", "setScrollBarSize", "ScrollBarSize", "Number", false));			bindings.push(new ParameterBinding("Window", "setScrollBarSliderSize", "ScrollBarSliderSize", "Number", false));			bindings.push(new ParameterBinding("Window", "setScrollBarImage", "ScrollBarImage", "String", false));			bindings.push(new ParameterBinding("Window", "setScrollBarSliderImage", "ScrollBarSliderImage", "String", false));			bindings.push(new ParameterBinding("Window", "setScrollBarSliderOutline", "ScrollBarSliderOutline", "Number", false));			bindings.push(new ParameterBinding("Window", "setScrollBarOutline", "ScrollBarOutline", "Number", false));			// Menu Bindings			bindings.push(new ParameterBinding("Menu", "setMenuTitle", "MenuTitle", "String", false));			bindings.push(new ParameterBinding("Menu", "setMenuTitleFont", "MenuTitleFont", "String", false));			bindings.push(new ParameterBinding("Menu", "setMenuTitleFontSize", "MenuTitleFontSize", "Number", false));			bindings.push(new ParameterBinding("Menu", "setMenuTitleTextColor", "MenuTitleTextColor", "Number", false));			bindings.push(new ParameterBinding("Menu", "setMenuTitleImage", "MenuTitleImage", "String", false));			bindings.push(new ParameterBinding("Menu", "setMenuTitleHeight", "MenuTitleHeight", "Number", false));			bindings.push(new ParameterBinding("Menu", "setMenuTitleWidth", "MenuTitleWidth", "String", false));			bindings.push(new ParameterBinding("Menu", "setDirection", "MenuDirection", "String", false));			bindings.push(new ParameterBinding("Menu", "setAlignment", "MenuAlignment", "String", false));			bindings.push(new ParameterBinding("Menu", "setListedType", "ListedType", "Component", false));			bindings.push(new ParameterBinding("Menu", "setListSpacing", "Spacing", "Number", false));			// Tab Bar Bindings   			bindings.push(new ParameterBinding("TabBar", "setDirection", "TabBarDirection", "String", false));   			bindings.push(new ParameterBinding("TabBar", "setListedType", "ListedType", "Component", false));			// Menuitem Bindings			bindings.push(new ParameterBinding("MenuItem", "setItemTextAlign", "ItemTextAlign", "String", false));			// Icon Bindings			bindings.push(new ParameterBinding("Icon", "setDroppable", "Droppable", "Boolean", false));			bindings.push(new ParameterBinding("Icon", "setIcon", "Icon", "String", false));			// TextDisplay Bindings			bindings.push(new ParameterBinding("TextDisplay", "setTextDisplayBold", "Bold", "Boolean", false));				bindings.push(new ParameterBinding("TextDisplay", "setTextDisplayAlign", "TextAlign", "String", false));			bindings.push(new ParameterBinding("TextDisplay", "setTextFieldScale", "Scale", "Boolean", false));			bindings.push(new ParameterBinding("TextDisplay", "setTextSelectable", "Selectable", "Boolean", false));			bindings.push(new ParameterBinding("TextDisplay", "setTextEditable", "Editable", "Boolean", false));			bindings.push(new ParameterBinding("TextDisplay", "setHTML", "HTML", "Boolean", false));			bindings.push(new ParameterBinding("TextDisplay", "setStyleSheet", "Style", "String", false));			// ListBox Bindings			bindings.push(new ParameterBinding("ListBox", "setScrollBarOutline", "ScrollBarOutline", "Number", false));			bindings.push(new ParameterBinding("ListBox", "setScrollVertical", "ScrollVertical", "Boolean", false));			bindings.push(new ParameterBinding("ListBox", "setScrollHorizontal", "ScrollHorizontal", "Boolean", false));			bindings.push(new ParameterBinding("ListBox", "setScrollBarSize", "ScrollBarSize", "Number", false));			bindings.push(new ParameterBinding("ListBox", "setScrollBarSliderSize", "ScrollBarSliderSize", "Number", false));			bindings.push(new ParameterBinding("ListBox", "setScrollBarImage", "ScrollBarImage", "String", false));			bindings.push(new ParameterBinding("ListBox", "setScrollBarSliderImage", "ScrollBarSliderImage", "String", false));			bindings.push(new ParameterBinding("ListBox", "setScrollBarSliderOutline", "ScrollBarSliderOutline", "Number", false));			bindings.push(new ParameterBinding("ListBox", "setListedType", "ListedType", "Component", false));			bindings.push(new ParameterBinding("ListBox", "setListSpacing", "Spacing", "Number", false));					// Button Bindings			bindings.push(new ParameterBinding("Button", "setButtonTextBold", "Bold", "Boolean", false));			bindings.push(new ParameterBinding("Button", "setDefaultState", "DefaultState", "String", false));			bindings.push(new ParameterBinding("Button", "setOverState", "OverState", "String", false));			bindings.push(new ParameterBinding("Button", "setDownState", "DownState", "String", false));      			bindings.push(new ParameterBinding("Button", "setIsToggle", "IsToggle", "Boolean", false));			// Image Bindings			bindings.push(new ParameterBinding("ImageDisplay", "setScaleImage", "Scale", "Boolean", false));			bindings.push(new ParameterBinding("ImageDisplay", "setScaleType", "ScaleType", "String", false));			bindings.push(new ParameterBinding("ImageDisplay", "setImageURL", "URL", "String", false));			bindings.push(new ParameterBinding("ImageDisplay", "setUseCache", "Cache", "Boolean", false));			// SWF Bindings			bindings.push(new ParameterBinding("SWFDisplay", "setScaleSWF", "Scale", "Boolean", false));			bindings.push(new ParameterBinding("SWFDisplay", "setScaleType", "ScaleType", "String", false));			bindings.push(new ParameterBinding("SWFDisplay", "setSWFUrl", "URL", "String", false));			// VideoSeek Bindings			bindings.push(new ParameterBinding("VideoSeek", "setVideoDisplay", "Video", "String", false));			bindings.push(new ParameterBinding("VideoSeek", "setControlDirection", "ControlDirection", "String", false));			bindings.push(new ParameterBinding("VideoSeek", "setSliderSize", "SliderSize", "Number", false));			bindings.push(new ParameterBinding("VideoSeek", "setSliderOutline", "SliderOutline", "Number", false));			bindings.push(new ParameterBinding("VideoSeek", "setSliderImage", "SliderImage", "String", false));			bindings.push(new ParameterBinding("VideoSeek", "setSliderButtonColor", "SliderButtonColor", "String", false));			bindings.push(new ParameterBinding("VideoSeek", "setSliderButtonColorDown", "SliderButtonColorDown", "String", false));			// PanelItem Bindings      			bindings.push(new ParameterBinding("PanelItem", "setPanelTextSize", "TextWidth", "Pointdata", false));  			bindings.push(new ParameterBinding("PanelItem", "setPanelTextSize", "TextHeight", "Pointdata", false));           			bindings.push(new ParameterBinding("PanelItem", "setPanelTextPosition", "TextX", "Pointdata", false));  			bindings.push(new ParameterBinding("PanelItem", "setPanelTextPosition", "TextY", "Pointdata", false));    	 			bindings.push(new ParameterBinding("PanelItem", "setItemId", "ItemId", "String", false));      			bindings.push(new ParameterBinding("PanelItem", "setButtonIsToggle", "ButtonIsToggle", "Boolean", false));    			bindings.push(new ParameterBinding("PanelItem", "setButtonDefaultState", "ButtonDefaultState", "String", false));     			bindings.push(new ParameterBinding("PanelItem", "setButtonOverState", "ButtonOverState", "String", false));     			bindings.push(new ParameterBinding("PanelItem", "setButtonDownState", "ButtonDownState", "String", false));     					}		public function addCustomBinding(c:String, fn:String, p:String, t:String, r:Boolean):void {			var newBinding:ParameterBinding = new ParameterBinding(c, fn, p, t, r);			insertCustomBinding(newBinding);		}		private function insertCustomBinding(newBinding:ParameterBinding):void {			bindings.push(newBinding);		}		public function getComponentParameters(componentType:String):Array {			var resultArray:Array = new Array();			for(var i:Number = 0; i<bindings.length; i++) {				if((bindings[i].getComponentType() == componentType) || (bindings[i].getComponentType() == "Abstract")) {					resultArray.push(bindings[i].getParamText());				}			}			return(resultArray);		}		public function getComponentMethods(componentType:String):Array {				var resultArray:Array = new Array();				for(var i:Number = 0; i<bindings.length; i++) {					if((bindings[i].getComponentType() == componentType) || (bindings[i].getComponentType() == "Abstract")) {						// Only add a given method name once						// This allows us to specify the same method (i.e. setSize) for multiple properties (width, height)						var alreadyAdded:Boolean = false;						for(var j:Number = 0; j<resultArray.length; j++) {							if(resultArray[j] == bindings[i].getMethod()) {								alreadyAdded = true;							}						}						if(!alreadyAdded) {							resultArray.push(bindings[i].getMethod());						}					}				}				return(resultArray);		}		public function getMethodBindings(paramMethod:String):Array {			var resultArray:Array = new Array();			for(var i:Number = 0; i<bindings.length; i++) {				if(bindings[i].getMethod() == paramMethod) {					resultArray.push(bindings[i]);				}			}			return(resultArray);		}	}}                                                                                          