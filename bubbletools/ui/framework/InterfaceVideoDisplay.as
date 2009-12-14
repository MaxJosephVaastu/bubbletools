﻿// bubbletools.* ===============================================================================// BubbleTools™ Web Application and User Interface Component Architecture for Actionscript 3// ©2007 Michael Szypula.  Any modifications to this file must keep this license block intact.// Developer : Michael Szypula// Contact : michael.szypula@gmail.com// License Information : Contact Developer to obtain license agreement.// =================================================================================================package bubbletools.ui.framework {		import flash.media.Video;	import flash.media.SoundTransform;	import flash.net.NetStream;	import flash.events.NetStatusEvent;	import bubbletools.ui.interfaces.Reporter;		import flash.display.Sprite;	import bubbletools.util.Pointdata;	import bubbletools.util.MouseEventCapture;	import bubbletools.ui.interfaces.IParameters;	import bubbletools.ui.eventing.*	import bubbletools.ui.framework.*	import bubbletools.ui.parameters.*	import bubbletools.ui.framework.ComponentView;	import bubbletools.util.Debug;		public class InterfaceVideoDisplay extends InterfaceComponent implements Reporter {	         		public var isProgressive:Boolean = false;             public var netstreamEventInfoCode:String; 		private var parameters:VideoDisplayParameters;		private var videoView:Video;		private var netstream:NetStream;		private var meta:Object;		private var playing:Boolean = false;		private var stopEvent:Boolean = false;		private var emptyEvent:Boolean = false;				private var videoVolume:Number = 1;			// sub clip control parameters		private var inTime:Number;		private var outTime:Number;			public function InterfaceVideoDisplay(parentComponent:InterfaceComponent){			super(parentComponent);			componentType = "VideoDisplay";			allowSubcomponents = false;						inTime = 0;			outTime = 0;		}                          			//  =====================================================================================================		//  Reporter Implementation		//			public function makeEvent(eventType:String):UIEvent {			var newEvent:UIEvent = UIEventManager.instance().createUIEvent(id, componentType, eventType);			return(newEvent);		}			//  =====================================================================================================		//  Required Override Methods		//			public override function setParameters(newParameters:IParameters):void {			globalParameters = newParameters;			parameters = VideoDisplayParameters(newParameters);		}		public override function displayComponent():void {			videoView = new Video(getParameters().getSize().X, getParameters().getSize().Y);			view.setContents(videoView);		}		public override function handleMouseEvent(clickType:String):void {			switch(clickType) {				case "press" :					bubbleEvent(UIEventType.VIDEO_PRESS);					break;				}		}			//  =====================================================================================================		//  Custom Methods		//		//  Events     			   public function onPlayStatus(info:Object):void {			Debug.output(this, info.code);             			if(isProgressive == false) {				switch (info.code) {					case "NetStream.Play.Complete":						bubbleEvent(UIEventType.VIDEO_COMPLETE);   						break;					default :						break;	  				}   			}                     			}          				public function onLastSecond(info:Object):void {						Debug.output(this, "thanks for calling this event, but why?");					}     				public function onCuePoint(info:Object):void {						Debug.output(this, "netstream onCuePoint called");					}                             			public function streamEvent(event:NetStatusEvent):void {					Debug.output(this, event.info.code);       			netstreamEventInfoCode = event.info.code;			bubbleEvent(UIEventType.NETSTREAM_EVENT_DUMP);						switch (event.info.code) {				case "NetStream.Play.StreamNotFound":     					Debug.output(this, "stream not found - message is : "+event.info.description);					bubbleEvent(UIEventType.STREAM_ERROR);					break;				case "NetStream.Play.Stop":  				    					if(isProgressive) {						// Set this flag to true since stop may occur up to 2 seconds before the video ends						stopEvent = true;						bubbleEvent(UIEventType.NETSTREAM_PLAY_STOP);											if(emptyEvent) {							emptyEvent = false;							bubbleEvent(UIEventType.VIDEO_COMPLETE);						}       					}					break;				case "NetStream.Buffer.Empty":					                      					if(isProgressive) {						emptyEvent = true;						bubbleEvent(UIEventType.BUFFER_EMPTY);											if(stopEvent) {							stopEvent = false;							bubbleEvent(UIEventType.VIDEO_COMPLETE);						}      					}					break;				case "NetStream.Buffer.Full":					bubbleEvent(UIEventType.BUFFER_FULL);					break;				case "NetStream.Play.Start":					bubbleEvent(UIEventType.NETSTREAM_PLAY_START);					break;				case "NetStream.Play.Complete":					break;				case "NetStream.Seek.Notify":					break;				case "NetStream.Buffer.Flush":					break;				default :					break;		        }				}			public function onMetaData(info:Object):void {			meta = info;			bubbleEvent(UIEventType.METADATA_LOADED);		}			//  Stream information			public function metaData():Object {			return(meta);		}				public function setInTime(iT:Number):void {			inTime = iT;		}				public function setOutTime(oT:Number):void {			outTime = oT;		}				public function totalTime():Number {			if(outTime > 0) {				return(outTime-inTime);			} else {				return(meta.duration);											}		}				// Returns the absolute netstream time		public function currentANSTime():Number {			if (netstream) { 				return(netstream.time - inTime);			} else {				return(0);			}		}			// Returns the time relative to the in and out time		public function currentTime():Number {			if (netstream) { 				return(netstream.time);			} else {				return(0);			}		}		//  Controls			public function startVideo(stream:NetStream, videoURL:String):void {						trace("••• " + this.isProgressive + " " + videoURL + " " + this.inTime + " " + this.outTime);						emptyEvent = false;			stopEvent = false;			meta = null;			netstream = stream;			netstream.addEventListener(NetStatusEvent.NET_STATUS, streamEvent);			netstream.client = this;			setVolume(videoVolume);			videoView.attachNetStream(netstream);						if(outTime == 0) {				netstream.play(videoURL);			} else {				netstream.play(videoURL,inTime, outTime-inTime);  // Parameters are netstream, start time and duration of clip			}						playing = true;		}				public function dump():void {						meta = null;			//netstream.removeEventListener(NetStatusEvent.NET_STATUS, streamEvent);			//netstream.client = null;			netstream = null;			playing = false;			stopEvent = false;			emptyEvent = false;			inTime=outTime=0;		}				public function format():void {						Debug.output(this, "Re format video display to honor aspect ratio");						if(meta) {				var h:Number = meta.height;				var w:Number = meta.width;				var a:Number = w/h;				var displayAreaW:Number = getCurrentSize().X;				var displayAreaH:Number = getCurrentSize().Y;							var aDisplay:Number = displayAreaW/displayAreaH;							var newH:Number;				var newW:Number;							if(aDisplay > a) {					Debug.output(this, "Video aspect is NARROWER than display");					Debug.output(this, "Video : "+a);					Debug.output(this, "Display : "+aDisplay);					newH = displayAreaH;					newW = newH*a;					Debug.output(this, "New video width : "+newW);					Debug.output(this, "New video height : "+newH);				} else {					Debug.output(this, "Video aspect is WIDER than display");					Debug.output(this, "Video : "+a);					Debug.output(this, "Display : "+aDisplay);					newW = displayAreaW;					newH = newW/a;					Debug.output(this, "New video width : "+newW);					Debug.output(this, "New video height : "+newH);				}							var offsetX:Number = (displayAreaW-newW)/2;				var offsetY:Number = (displayAreaH-newH)/2;							view.offsetContents(offsetX, offsetY);				view.resizeContents(newW, newH);						}		}				public function refresh():void {			meta = null;			videoView = new Video(getParameters().getSize().X, getParameters().getSize().Y);			view.changeContents(videoView);			playing = false;		}				public function pause():void {			if(netstream) {				netstream.pause();			}			playing = false;		}				public function play():void {			netstream.resume();			playing = true;		}				public function end():void {			netstream.seek(totalTime());		}				public function setVolume(newVolume:Number):void {			videoVolume = newVolume;			if(netstream) {				var transform:SoundTransform = netstream.soundTransform;				transform.volume = videoVolume;            	netstream.soundTransform = transform;			}		}				// seek to the absolute netstream time		public function ANSSeek(time:Number):void {			netstream.seek(time);		}				// seek to the relative netstream time determined by the inTime		public function seek(time:Number):void {			netstream.seek(time);		}				public function rewind():void {			Debug.output(this, "Netstream =" + netstream);			netstream.pause();			// in/out time fix			netstream.seek(0);			playing = false;		}		public function isPlaying():Boolean {			return(playing);		}		}}