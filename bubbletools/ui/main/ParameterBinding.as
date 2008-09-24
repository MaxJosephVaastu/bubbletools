﻿// bubbletools.* ===============================================================================// BubbleTools™ Web Application and User Interface Component Architecture for Actionscript 3// ©2007 Michael Szypula.  Any modifications to this file must keep this license block intact.// Developer : Michael Szypula// Contact : michael.szypula@gmail.com// License Information : Contact Developer to obtain license agreement.// =================================================================================================package bubbletools.ui.main {		public class ParameterBinding {			private var componentType:String;		private var setMethod:String;		private var paramText:String;		private var paramType:String;		private var required:Boolean;			public function ParameterBinding(componentType:String, setMethod:String, paramText:String, paramType:String, required:Boolean) {			this.componentType = componentType;			this.setMethod = setMethod;			this.paramText = paramText;			this.paramType = paramType;			this.required = required;			//Documentation.instance().record(this);		}		public function getMethod():String {			return(setMethod);		}		public function getComponentType():String {			return(componentType);		}		public function getParamText():String {			return(paramText);		}		public function getParamType():String {			return(paramType);		}		public function getRequired():Boolean {			if(required == null) {				required = false;			}			return(required);		}	}}