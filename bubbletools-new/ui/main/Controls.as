﻿// bubbletools.* ===============================================================================// BubbleTools™ Web Application and User Interface Component Architecture for Actionscript 3// ©2007 Michael Szypula.  Any modifications to this file must keep this license block intact.// Developer : Michael Szypula// Contact : michael.szypula@gmail.com// License Information : Contact Developer to obtain license agreement.// =================================================================================================package bubbletools.ui.main {		import bubbletools.ui.interfaces.UIView;	import bubbletools.ui.interfaces.UIControl;		public class Controls {				private static var _instance:Controls;				private var controls:Array;					// Array for added controls		private var view:View;								public static function create(view:View):Controls {			if (Controls._instance == null) {				Controls._instance = new Controls();				_instance.controls = new Array();				_instance.view = view;			}			return _instance;		}				public function add(type:String, control:UIControl):void {			trace("add control "+type);			_instance.controls[type] = control;		}				public function getControl(type:String):UIControl {			//if(arguments.callee == View.control) {				if(_instance.controls[type] == null) {					trace("[WARNING] [Controls] Requested control '"+type+"' does not exist");					return (null);				} else {					return(_instance.controls[type]);				}			//} else {			 //   trace("[WARNING] [Controls] control request can only be made from View");			 //   return(null);			//}		}				public static function clear():void {			_instance.controls = new Array();		}			}}