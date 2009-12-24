﻿package com.application {		import bubbletools.core.async.*;	import bubbletools.core.eventing.*;	import bubbletools.core.library.*;	import bubbletools.core.threading.*;		import bubbletools.ui.eventing.*;	import bubbletools.ui.framework.*;	import bubbletools.ui.interfaces.*;	import bubbletools.ui.main.*;	import bubbletools.ui.parameters.*;		import bubbletools.util.*;	//import bubbletools.util.javascript.*;	public class App {				private var appView:AppMainView;		public function App() {						//	Your application code here; logic, data model creation, class instantion, etc.						//  Initialize the UI - this can be called from anywhere in your app.  It must be called			//  before you create your View, of course.						UI.init();			UI.setImagePath("uiml/img/");  // Here we are setting a special image path, see below for details.   						// UIMLView.useLazyLoad = true; 						//  =====================================================================================================			//  Customizing paths and behavior for loading your UIML image backgrounds :			//			//  * UI.setImagePath(path:String) --> Allows you to alter the default path for loading images.			//  by default, images will be assumed to be in the same directory as your UIML file.			//			// 	* UI.addImagePathProxy(name:String, path:String) --> Allows you to make use of your own shorthand			//	in your UIML file.  If your image is on a long URL, you can assign a short name to a given path.			//	For example,			//  UI.addImagePathProxy("default", "http://mywebsite.com/app/uiml/img/default/");  or			//  UI.addImagePathProxy("default", "uiml/img/default/");			//  In your UIML file, you would preface your images with "default/"			//			//  * UI.addUIMLPathProxy(name:String, path:String) --> Works the same way as image paths, allowing			//  you to use a shorthand for UIML file locations.  This is only used when you request to load			//  additional UIML files.			//			//  * UIMLView.useLazyLoad = true; --> Enables or disables lazy load for UI images.  When this is turned on,			//  your UI will begin to draw immediately, before any images are loaded.  Set based on your performance			//  requirements.			//  =====================================================================================================									//	Create the main View!						//  Here you create an instance of your class extends View & implements UIView, in this case AppMainView			//  When passing the name of the UIML file, this can come from anywhere -			//  embed parameters, a class which selects your UIML file, etc.			//  In this example we are just passing a simple String.									appView = new AppMainView("uiml/data/helloworld.xml");						//  When your app is ready to start drawing (i.e. your other app classes have loaded up their content)						appReady();					}				public function appReady():void {						//  Inform your main view that your app is ready, content is loaded, etc.			//  Once you called View.applicationReady(), View.applicationComplete() will be called automatically			//  when the UI is loaded.  applicationComplete() is the place to instantiate your control classes.						View.applicationReady();					}			}}