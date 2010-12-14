﻿// bubbletools.* ===============================================================================// BubbleTools™ Web Application and User Interface Component Architecture for Actionscript 3// ©2007 Michael Szypula.  Any modifications to this file must keep this license block intact.// Developer : Michael Szypula// Contact : michael.szypula@gmail.com// License Information : Contact Developer to obtain license agreement.// =================================================================================================package bubbletools.ui.eventing {	import bubbletools.core.eventing.EventObj;	public class UIEvent extends EventObj {		public function UIEvent(name:String, info:Object, id:Number) {			this.name = name;			this.info = info;			this.id = id;			type = "UIEvent";		}		public function print():void {			trace("UIEvent: " + name + " id: " + id);			for (var x:String in info) {				trace(" ---> " + x + ": " + info[x]);			}		}	}}