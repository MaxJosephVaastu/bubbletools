﻿// bubbletools.* ===============================================================================// BubbleTools™ Web Application and User Interface Component Architecture for Actionscript 3// ©2007 Michael Szypula.  Any modifications to this file must keep this license block intact.// Developer : Michael Szypula// Contact : michael.szypula@gmail.com// License Information : Contact Developer to obtain license agreement.// =================================================================================================package bubbletools.core.async {	import flash.net.URLRequest;	import flash.net.URLLoader;		import flash.events.*;	import bubbletools.core.async.AsyncLoader;	import bubbletools.core.threading.Threaded;	public class MultiLoader extends Threaded {			private var returnClass:Threaded;		private var dataLoaders:Array;		private var returnHandlers:Array;		private var loadIndex:Number = 0;		private var returnThreadId:Number;			public function MultiLoader(returnClass:Threaded) {			super();			idName = "Multi_Loader";			this.returnClass = returnClass;			returnThreadId = this.returnClass.getThreadId();			returnHandlers = new Array();			dataLoaders = new Array();		}		public function addLoadRequest(filename:String, handler:Function):void {			returnHandlers.push(handler);			var myLoader = new DataLoader();			myLoader.setParams(filename, this);			dataLoaders.push(myLoader)		}		public function startLoad():void {			returnClass.setIncomplete();			Debug.output(this, "[MultiLoader] Starting Load of "+dataLoaders[loadIndex].sourceFile);			dataLoaders[loadIndex].startLoad();		}		public function completeLoad(theData):void {			returnHandlers[loadIndex](theData);			loadIndex++;			loadNext();		}		public function errorLoading():void {			Debug.output(this, "[MultiLoader] failed to load "+dataLoaders[loadIndex].sourceFile);			loadIndex++;			loadNext();		}		public function loadNext():void {			if(loadIndex < dataLoaders.length) {				startLoad();			} else {				endLoading();			}		}		public function endLoading():void {			returnClass.resumeOnThread(returnThreadId);			returnClass.setComplete();		}		}}