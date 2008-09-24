﻿package bubbletools.ui.main {		import flash.utils.Timer;	import flash.events.TimerEvent;	import bubbletools.core.threading.ThreadManager;	import bubbletools.core.threading.Threaded;	import bubbletools.ui.interfaces.UIView;	import bubbletools.ui.interfaces.IComponent;	import bubbletools.ui.main.*;	import bubbletools.ui.framework.*;	import bubbletools.ui.parameters.*;	//  =====================================================================================================	//  UIMLView : Loads a UIML file, renders UI	//	public class UIMLView extends Threaded {				public static var compile:Boolean = false;				public static var VIEW_STATUS:Number = 0;		public static var VALID:Number = 0;		public static var INVALID:Number = 1;				private static var _instance:UIMLView;				public static var useLazyLoad:Boolean = false;				private var uiView:UIView;						// Main class of the app that implements UIView			private var baseUIML:String;					// Filename of the base UI file		private var UIMLxml:XML;						// UIML data		private var UIArray:Array;						// Array of any injected UI files				private var injection:Boolean = false;			// Flag for subsequent loads		private var injectedType:String;				// Flag for subsequent loads		private var busyLoading:Boolean = false;				private var UILoadComplete:Boolean = false;		private var UITimer:Timer;			// Loads the main view, will destroy a prior view if called again and assign all delegation		// to the new UIView implementation passed in				public static function create(UIML:String, uiView:UIView):UIMLView {			if(_instance != null) {				_instance.clear();			}			_instance = new UIMLView();			_instance.idName = "UIMLView";			_instance.UIArray = new Array();			_instance.uiView = uiView;			_instance.baseUIML = UIML;			if(UIML != null) {				_instance.busyLoading = true;				_instance.load(UIML);			}			return(_instance);		}				private function load(UIML:String):void {						trace("[View] load UIML file : "+UIML);			UIMLLoader.instance().addLoadRequest(UIML);			ThreadManager.createThread();			ThreadManager.setThreadStart(UIMLLoader.instance(), UIMLLoader.instance().startLoad);			if(UIMLView.useLazyLoad) {				ThreadManager.addToCurrentThread(this, this.render);			} else {				ThreadManager.addToCurrentThread(UI.library(), UI.library().loadBitmaps);				ThreadManager.addToCurrentThread(this, this.render);			}			ThreadManager.startThread();		}				private function clear():void {			_instance.UIArray = new Array();			Controls.clear();			UI.clear();		}				//  =====================================================================================================		//  Externally available		//				public static function loadAdditional(uiName:String, UIML:String, target:IComponent):void {			if(!_instance.busyLoading) {				if(target != null) {					UIMLParser.setInjectNode(target);				}				_instance.injection = true;				_instance.injectedType = uiName;				UIML = UI.proxyPath(UIML);				_instance.UIArray[uiName] = UIML;				_instance.busyLoading = true;				_instance.load(UIML);			}		}				public static function loadFailed():void {			VIEW_STATUS = INVALID;			_instance.setThreadTerminated();			_instance.busyLoading = false			_instance.uiView.renderFailed();		}				public static function reset():void {			_instance.clear();			_instance.injection = false;			_instance.UILoadComplete = false;			_instance.load(_instance.baseUIML);		}				public static function saveXML(UIMLxml:XML):void {			if(_instance.injection) {				_instance.UIArray[_instance.injectedType] = UIMLxml;			} else {				_instance.UIMLxml = UIMLxml;			}		}				public static function rootxml():XML {			return(_instance.UIMLxml);		}				public static function xml(uiName:String):XML {			return(_instance.UIArray[uiName]);		}				//  =====================================================================================================		//  Check to see if a certain UI exists		//				public static function exists(uiName:String):Boolean {			if(_instance.UIArray[uiName] != null) {				return(true);			} else {				return(false);			}		}			//  =====================================================================================================		//  Renders skin before any content is ready 		//			public function render():void {					busyLoading = false;						trace("Render UIML : Injection Mode = "+injection);						UI.library().loadBitmaps();			UILoadComplete = true;			UI.refreshView();						//  Tell the main application view the render is complete						if(injection) {				uiView.renderAdditionalStarted(injectedType);				injection = false;				injectedType = "";			} else {				uiView.renderStarted();			}					}			//  =====================================================================================================		//  Returns control to the main application view		//						public function notifyWhenReady():void {			if(!UILoadComplete) {				if(UITimer == null) {					trace("UI waiting on UILoadComplete")					UITimer = new Timer(100, 0);					UITimer.addEventListener("timer", autoNotify);					UITimer.start();					}			} else {				if(UITimer != null) {					UITimer.stop();				}				uiView.applicationComplete();			}		}			public function autoNotify(event:TimerEvent):void {			notifyWhenReady();		}		}}