﻿// bubbletools.* ===============================================================================// BubbleTools™ Web Application and User Interface Component Architecture for Actionscript 3// ©2007 Michael Szypula.  Any modifications to this file must keep this license block intact.// Developer : Michael Szypula// Contact : michael.szypula@gmail.com// License Information : Contact Developer to obtain license agreement.// =================================================================================================package bubbletools.util {	public class MultiId {				private var ids:Array;			public static function createMultiId():MultiId {			var id = new MultiId();			id.ids = new Array();			return(id);		}		public function setId(id:Number, thread:String):void {			ids[thread] = id;		}		public function getId(thread):Number {			if(ids[thread] != undefined) {				return(ids[thread]); 			} else {				trace("--> Attempt to get id failed for "+thread);				return(null);			}		}	}}