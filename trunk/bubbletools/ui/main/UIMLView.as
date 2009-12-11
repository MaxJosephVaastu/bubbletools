﻿package bubbletools.ui.main {		import flash.utils.Timer;	import flash.utils.getTimer;	import flash.events.TimerEvent;	import bubbletools.core.threading.ThreadManager;	import bubbletools.core.threading.Threaded;	import bubbletools.ui.interfaces.UIView;	import bubbletools.ui.interfaces.IComponent;	import bubbletools.ui.main.*;	import bubbletools.ui.framework.*;	import bubbletools.ui.parameters.*;	import bubbletools.util.Debug;	//  =====================================================================================================	//  UIMLView : Loads a UIML file, renders UI	//	public class UIMLView extends Threaded {				public static var compile:Boolean = false;				public static var VIEW_STATUS:Number = 0;		public static var VALID:Number = 0;		public static var INVALID:Number = 1;				private static var _instance:UIMLView;				public static var useLazyLoad:Boolean = false;				private var uiView:UIView;						// Main class of the app that implements UIView			private var baseUIML:String;					// Filename of the base UI file		private var UIMLxml:XML;						// UIML data        		private var UIArray:Array;						// Array of boolean indicating a UI file is loaded		private var UIStorageArray:Array;				// Array of stored UI files				private var injection:Boolean = false;			// Flag for subsequent loads		private var injectedType:String;				// Flag for subsequent loads		private var busyLoading:Boolean = false;				private var UILoadComplete:Boolean = false;		private var UITimer:Timer;			// Loads the main view, will destroy a prior view if called again and assign all delegation		// to the new UIView implementation passed in				public static function create(UIML:String, uiView:UIView):UIMLView {			if(_instance != null) {				_instance.clear();			}			_instance = new UIMLView();			_instance.idName = "UIMLView";			_instance.UIArray = new Array();    			_instance.UIStorageArray = new Array();			_instance.uiView = uiView;			_instance.baseUIML = UIML;			if(UIML != null) {				_instance.busyLoading = true;				_instance.load(UIML);			}			return(_instance);		}				private function load(UIML:String):void {						Debug.output(this, "[View] load UIML file : "+UIML);			UIMLLoader.instance().addLoadRequest(UIML);			ThreadManager.createThread();			ThreadManager.setThreadStart(UIMLLoader.instance(), UIMLLoader.instance().startLoad);			if(UIMLView.useLazyLoad) {				ThreadManager.addToCurrentThread(this, this.render);			} else {				ThreadManager.addToCurrentThread(UI.library(), UI.library().loadBitmaps);				ThreadManager.addToCurrentThread(this, this.render);			}			ThreadManager.startThread();		}				private function clear():void {			_instance.UIArray = new Array();			Controls.clear();			UI.clear();		}				//  =====================================================================================================		//  Externally available		//				public static function loadAdditional(uiName:String, UIML:String, target:IComponent):void {			if(!_instance.busyLoading) {   				_instance.busyLoading = true;				if(target != null) {					UIMLParser.setInjectNode(target);				}				_instance.injection = true;				_instance.injectedType = uiName; 				_instance.UIArray[uiName] = false;  				UIML = UI.proxyPath(UIML);				_instance.load(UIML);			} else {				Debug.output(_instance, "UIMLView was locked, did not attempt load for "+UIML);			}		}				public static function loadFailed(UIML:String):void {			VIEW_STATUS = INVALID;			_instance.setThreadTerminated();			_instance.busyLoading = false			_instance.uiView.renderFailed(UIML);		}				public static function reset():void {			_instance.clear();			_instance.injection = false;			_instance.UILoadComplete = false;			_instance.load(_instance.baseUIML);		}     				public static function saveXML(UIMLxml:XML):void {			if(_instance.injection) {				_instance.UIStorageArray[_instance.injectedType] = UIMLxml;			} else {				_instance.UIMLxml = UIMLxml;			}		}				public static function rootxml():XML {			return(_instance.UIMLxml);		}				public static function xml(uiName:String):XML {			return(_instance.UIStorageArray[uiName]);		}				//  =====================================================================================================		//  Check to see if a certain UI exists		//				public static function exists(uiName:String):Boolean {   			Debug.output(_instance, "Check for UI : "+uiName+" ---> "+_instance.UIArray[uiName]);			if(_instance.UIArray[uiName]) {				return(true);			} else {				return(false);			}		}			//  =====================================================================================================		//  Renders skin before any content is ready 		//			public function render():void {   			   					var timeElapsed:String = String(getTimer());			Debug.output(this, "[UIMLView] Render UIML start  time elapsed : "+timeElapsed);						UI.library().loadBitmaps();			UILoadComplete = true;			UI.refreshView();						//  Tell the main application view the render is complete						if(injection) {       				//Debug.output(this, "Injected type XML = "+_instance.UIStorageArray[injectedType]); 				uiView.renderAdditionalStarted(injectedType);				injection = false;				injectedType = "";			} else {				uiView.renderStarted();			}        						//  Mark injected UI as loaded			                 			if(injection) {				UIArray[injectedType] = true;			}			//  Allow additional loads					busyLoading = false; 					}			//  =====================================================================================================		//  Returns control to the main application view		//						public function notifyWhenReady():void {			if(!UILoadComplete) {				if(UITimer == null) {					Debug.output(this, "[UIMLView] waiting on UILoadComplete before starting app.")					UITimer = new Timer(100, 0);					UITimer.addEventListener("timer", autoNotify);					UITimer.start();					}			} else {				if(UITimer != null) {					UITimer.stop();				}				uiView.applicationComplete();			}		}			public function autoNotify(event:TimerEvent):void {			notifyWhenReady();		}		}}