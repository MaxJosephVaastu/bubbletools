﻿// bubbletools.* ===============================================================================// BubbleTools™ Web Application and User Interface Component Architecture for Actionscript 3// ©2007 Michael Szypula.  Any modifications to this file must keep this license block intact.// Developer : Michael Szypula// Contact : michael.szypula@gmail.com// License Information : Contact Developer to obtain license agreement.// =================================================================================================package bubbletools.util.javascript {	public class JavascriptFile {				public static var XML_SIMPLE = 0;		public static var XML_CDATA = 1;				private var XML_FORMAT;				private var filename:String;		private var script:String;		private var jsXML:XML;		private var jsFunctions:Array;			public function JavascriptFile(filename:String) {			this.filename = filename;			jsFunctions = new Array();		}		public function getFileName():String {			return(filename);		}		public function setJavascript(script:String):void {			this.script = script;			var q = String.fromCharCode(34);			if(this.script.indexOf("<") != -1 || this.script.indexOf(">") != -1 || this.script.indexOf(q) != -1) {				XML_FORMAT = XML_CDATA;			} else {				XML_FORMAT = XML_SIMPLE;			}			jsXML = JavascriptParser.parse(this.script, XML_FORMAT);			buildFunctions();		}		public function buildFunctions():void {			if(XML_FORMAT == XML_SIMPLE) {				var nodes:XMLList = jsXML.child("jsnode");				for(var i:Number = 0; i<nodes.length(); i++) {					if(nodes[i].attribute("data")) {						if(nodes[i].attribute("data").indexOf("function") != -1) {							var jsFn:JavascriptFunction = new JavascriptFunction(nodes[i], XML_FORMAT);							jsFunctions[jsFn.fnName()] = jsFn;						}					}				}			} else if (XML_FORMAT == XML_CDATA) {				var nodes:XMLList = jsXML.child("jsnode");				for(var i:Number = 0; i<nodes.length(); i++) {					if(nodes[i].child(0).indexOf("function") != -1) {						var jsFn:JavascriptFunction = new JavascriptFunction(nodes[i], XML_FORMAT);						jsFunctions[jsFn.fnName()] = jsFn;					}				}			}		}		public function getJavascript():String {			return(script);		}		public function getFunctions():Array {			return(jsFunctions);		}	}}