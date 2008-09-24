﻿// bubbletools.* ===============================================================================// BubbleTools™ Web Application and User Interface Component Architecture for Actionscript 3// ©2007 Michael Szypula.  Any modifications to this file must keep this license block intact.// Developer : Michael Szypula// Contact : michael.szypula@gmail.com// License Information : Contact Developer to obtain license agreement.// =================================================================================================package bubbletools.ui.main {		import flash.xml.XMLNode;	import bubbletools.ui.interfaces.IComponent;	import bubbletools.ui.framework.UI;	import bubbletools.ui.framework.InterfaceComponent;	import bubbletools.ui.interfaces.IParameters;	import bubbletools.ui.parameters.InterfaceParameters;	import bubbletools.ui.main.ComponentTypes;		public class UIMLParser {				private var UIMLData:XML;		private var injectNode:IComponent;				private static var _instance:UIMLParser = null;		public static function instance():UIMLParser {			if (UIMLParser._instance == null) {				UIMLParser._instance = new UIMLParser();			}			return UIMLParser._instance;		}				public static function setInjectNode(node:IComponent):void {			_instance.injectNode = node;		}				public function UIMLParser(){			injectNode = UI.root()		}				public function parseData(UIMLData:XML):void {						if(UIMLData.child("Theme") != undefined) {								var theme:XMLList = UIMLData.child("Theme");								if(theme.child("TintColor")) {					var tintColor:XMLList = theme.child("TintColor");					UI.setTintValues(tintColor.attribute("r"), tintColor.attribute("g"), tintColor.attribute("b"));				}								if(theme.child("OutlineColor")) {					var outlineColor:XMLList = theme.child("OutlineColor");					UI.setOutlineColor(outlineColor.attribute("color"));				}								if(theme.child("Defaults")) {					trace("Adding defaults from UIML");					UIMLDefaults.instance().parseDefaultsXML(theme.child("Defaults"));				}							}						var UIML:XMLList = XMLList(UIMLData);						parseList(UIML, injectNode);						// Check for a plist at the start of the UIML file						var plist:XMLList = UIML.child("plist");						if((plist != null) && (plist != undefined)) {				var plistXML = XML(plist.toXMLString());				trace("Additional properties found : "+plistXML);				UI.store(plistXML);			}					}				// Parses a segment of XML and creates the component(s) described under the given parent component				public function parseList(UIML:XMLList, parentComponent:IComponent):void {						var components:XMLList = UIML.elements("Component");								if(components.length() > 0) {									var parameters:XMLList = components.elements("Parameters");								if(components.length() != parameters.length()) {					trace("Improperly specified UI XML, parameters length does not equal components length.");				} else {													for(var j:Number = 0; j<components.length(); j++) {												var param:XML = parameters[j];												var newComponent:IComponent = buildComponent(parentComponent, components[j].attribute("type"), components[j].attribute("id"), param);												var subcomponents:XMLList = components[j].elements("Subcomponents");				 						if(subcomponents.length() > 0) {							for(var i:Number = 0; i<subcomponents.length(); i++) {								parseList(XMLList(subcomponents[i]), newComponent);							}						}					}				}							} else {				trace("End of components reached for XML list.")			}			//						}				public function buildComponent(parentComponent:IComponent, componentType:String, componentId:String, param:XML):IComponent {									if(ComponentTypes.instance().hasType(componentType)) {				var newParams:InterfaceParameters = UIMLParams.instance().createParameters(componentType, componentId, param);				var newComponent = InterfaceComponent(parentComponent).addComponent(componentType, newParams);			} else {				trace("Type '"+componentType+"' does not exist.")			}			return(IComponent(newComponent));		}			}}