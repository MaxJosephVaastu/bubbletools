// bubbletools.* ===============================================================================// BubbleTools™ Web Application and User Interface Component Architecture for Actionscript 3// ©2007 Michael Szypula.  Any modifications to this file must keep this license block intact.// Developer : Michael Szypula// Contact : michael.szypula@gmail.com// License Information : Contact Developer to obtain license agreement.// =================================================================================================package bubbletools.ui.framework {	import flash.system.LoaderContext;		import flash.display.Loader;	import flash.net.URLRequest;	import flash.display.LoaderInfo;	import flash.events.*;	import bubbletools.util.Pointdata;	import bubbletools.ui.eventing.UIEvent;	import bubbletools.ui.eventing.UIEventType;	import bubbletools.ui.eventing.UIEventManager;	import bubbletools.ui.framework.InterfaceComponent;	import bubbletools.ui.interfaces.IParameters;	import bubbletools.ui.interfaces.Reporter;	import bubbletools.ui.parameters.ImageDisplayParameters;	import bubbletools.ui.framework.ComponentView;	import bubbletools.util.MouseEventCapture;	public class InterfaceImageDisplay extends InterfaceComponent implements Reporter {			private var parameters:ImageDisplayParameters;		private var autoDisplay:Boolean = false;		private var fade:Number = 0;		private var imgContext:LoaderContext;		private var imgLoader:Loader;			public function InterfaceImageDisplay(parentComponent:InterfaceComponent){			super(parentComponent);			componentType = "ImageDisplay";			allowSubcomponents = false; 		}				//  =====================================================================================================		//  Reporter Implementation		//		public function makeEvent(eventType:String):UIEvent {			var newEvent:UIEvent = UIEventManager.instance().createUIEvent(id, componentType, eventType);			return(newEvent);		}					//  =====================================================================================================		//  Required Override Methods		//			public override function setParameters(newParameters:IParameters):void {			globalParameters = newParameters;			parameters = ImageDisplayParameters(newParameters);		}		public override function displayComponent():void {			loadImage();		}			public override function handleMouseEvent(clickType:String):void {			switch(clickType) {				case "press" :					bubbleEvent(UIEventType.IMAGE_PRESS);					break;				case "release" :					bubbleEvent(UIEventType.IMAGE_RELEASE);					break;				case "over" :					bubbleEvent(UIEventType.IMAGE_OVER);					break;				case "release_outside" :					bubbleEvent(UIEventType.IMAGE_RELEASE_OUTSIDE);					break;					case "out" :					bubbleEvent(UIEventType.IMAGE_OUT);					break;				case "move" :					bubbleEvent(UIEventType.IMAGE_MOVE);					break;				default:					break;				}					}			//  =====================================================================================================		//  Custom Methods		//			public function updateImage(imageURL):void {			parameters.setImageURL(imageURL);			loadImage();		}		public function showWhenReady(fade:Number):void {			this.fade = fade;			autoDisplay = true;		}				public function disableAutoDisplay():void {						autoDisplay = false;					}				public function ready():void {			if(autoDisplay) {				if(fade > 0) {					fadeImageIn(fade);					fade = 0;				} else {					show();				}				autoDisplay = false;			}		}		public function loadImage():void {			if(parameters.alreadyLoaded()) {				Debug.output(this, "[ImageDisplay] : Using cached image for "+getId(), parameters.getImageURL());				view.changeImage(parameters.getCached());				ready();			} else {				if(parameters.getImageURL() != null) {									imgLoader = new Loader();					imgContext = new LoaderContext();										if(parameters.getUseCache()) {			      		imgContext.checkPolicyFile = true;					}										imgLoader.contentLoaderInfo.addEventListener(Event.INIT, imageLoaded);										// Error handling					imgLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, loadFailed);										// Load request											var url:String = parameters.getImageURL();					var urlReq:URLRequest = new URLRequest(url);					imgLoader.load(urlReq, imgContext);				}			}		}	    public function imageLoaded(event:Event):void {  					var img:Loader = Loader(event.target.loader);					if(parameters.getUseCache()) {				view.changeImage(parameters.makeCache(img));			} else {				Debug.output(this, "[ImageDisplay] : skipping bitmap draw for "+parameters.getImageURL());				view.setContents(img);			}					if(parameters.getScaleType() == "fit") {      				Debug.output(this, "[ImageDisplay] : centering image to fit");				view.centerImage(getParameters().getSize());			}			ready();	    }				public function loadFailed(event:IOErrorEvent):void {			Debug.output(this, "[ImageDisplay] : Load failed for "+parameters.getImageURL());		}		public function fadeImageIn(seconds:Number):void {			view.fadeIn(seconds);		}		public function fadeImageOut(seconds:Number):void {			view.fadeOut(seconds);		}	}}