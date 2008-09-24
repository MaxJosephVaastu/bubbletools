﻿// bubbletools.* ===============================================================================// BubbleTools™ Web Application and User Interface Component Architecture for Actionscript 3// ©2007 Michael Szypula.  Any modifications to this file must keep this license block intact.// Developer : Michael Szypula// Contact : michael.szypula@gmail.com// License Information : Contact Developer to obtain license agreement.// =================================================================================================package bubbletools.core.eventing {		import bubbletools.core.eventing.IEvent;	public class EventManager {			private static var _instance:EventManager = null;		private var events:Array;		private var eventCount:Number;		private var eventWatcher:uint;		public static function instance():EventManager {			if (EventManager._instance == null) {				EventManager._instance = new EventManager();			}			return EventManager._instance;		}		public function EventManager(){			events = new Array();				eventCount = 0;			}		private function listEvents():void {			trace("EventManger : event count is "+eventCount);			trace("EventManger : events array length is "+events.length);			for (var i=0; i<events.length; i++) {				trace(events[i].getType()+" --> "+events[i].name);			}		}		private function validateEvent(name:String, info:Object, eventType:Class):Boolean {			if(isData(name) && isData(info) && isData(eventType)) {				return(true);			} else {				return(false);			}		}		private function isData(o:Object):Boolean {			if((o != null) && (o != undefined)) {				return(true);			} else {				return(false);			}		}		public function createEvent(name:String, info:Object, eventType:Class):IEvent {		//	if(validateEvent(name, info, eventType)) {				var id = events.length;				events.push(new eventType(name, info, id));				var newEvent = events[id];				eventCount++;				return(newEvent);		//	} else {		//		trace("[ERROR] Invalid Event data sent to event manager.");		//		return(null);		//	}		}		public function expireEvent(id):void {			// say NO to memory leaks			var expiredEvent = events.splice(id,1);			delete(expiredEvent[0]);			expiredEvent = null;			eventCount = events.length;		}	}}