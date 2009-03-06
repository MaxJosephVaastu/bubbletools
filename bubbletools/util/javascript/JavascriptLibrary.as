﻿// bubbletools.* ===============================================================================// BubbleTools™ Web Application and User Interface Component Architecture for Actionscript 3// ©2007 Michael Szypula.  Any modifications to this file must keep this license block intact.// Developer : Michael Szypula// Contact : michael.szypula@gmail.com// License Information : Contact Developer to obtain license agreement.// =================================================================================================package bubbletools.util.javascript {	import bubbletools.core.async.MultiLoader;		import bubbletools.core.threading.Requesting;		public class JavascriptLibrary extends Requesting {		private var filenames:Array;		private var javascript:Array;		private var jsFunctions:Array;		private var index:Number = 0;			public function JavascriptLibrary(){					idName = "Javascript_Library";					javascript = new Array();			filenames = new Array();			jsFunctions = new Array();		}		public function addJavascriptFile(jsfile:JavascriptFile):void {					// Skip file addition if there is a file with the same ID is already loaded					var alreadyLoaded:Boolean = false					if(javascript[jsfile.getFileName()] != null) {				if(javascript[jsfile.getFileName()].getJavascript() != null);				alreadyLoaded = true;			}					if(!alreadyLoaded) {				filenames.push(jsfile);			}		}		public function loadScripts():void {			if(filenames.length > 0) {				trace("[JavascriptLibrary] load "+filenames.length+" scripts");				var loader = new MultiLoader(this);				for(var i:Number = 0; i<filenames.length; i++) {					loader.addLoadRequest(filenames[i].getFileName(), jsLoaded);				}				loader.startLoad();			} else {				setComplete();			}		}		public function jsLoaded(data:String):void {			var loadedFile:JavascriptFile = filenames[index];			trace("[JavascriptLibrary] loaded script file "+loadedFile.getFileName());			loadedFile.setJavascript(data);			javascript[loadedFile.getFileName()] = loadedFile;			for(var js in loadedFile.getFunctions()) {				jsFunctions[loadedFile.getFunctions()[js].fnName()] = loadedFile.getFunctions()[js];			}			index++;		}		public function getJSFile(id:String):JavascriptFile {			return(javascript[id]);		}		public function jsFunction(fn:String):JavascriptFunction {			return jsFunctions[fn];		}		public function functions():Array {			return(jsFunctions);		}	}}