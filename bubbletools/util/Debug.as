﻿package bubbletools.util {	import flash.utils.getQualifiedClassName;	import bubbletools.util.Strings;	public class Debug {				private static var _instance:Debug;  				private var debugHooks:Array;		public static function instance():Debug {			if (_instance == null) {				_instance = new Debug();			}			return _instance;		} 				public static function addHook(fn:Function):void {			_instance.debugHooks.push(fn);		}				public static function clearHooks():void {			_instance.debugHooks = new Array();		}          				public static function output(callingClass:Object, txt:String):void {			var showText:String = "["+getQualifiedClassName(callingClass)+"] "+txt;			showText = Strings.replaceInString(showText, "::", "] [");			if (Debug._instance != null) {				trace(showText);  				if(_instance.debugHooks.length > 0) {					for(var i:Number = 0; i<_instance.debugHooks.length; i++) {						_instance.debugHooks[i](showText);					}				}			}				}				public function Debug(){ 			debugHooks = new Array();		}			}}