// bubbletools.* ===============================================================================
// BubbleTools™ Web Application and User Interface Component Architecture for Actionscript 3
// ©2007 Michael Szypula.  Any modifications to this file must keep this license block intact.
// Developer : Michael Szypula
// Contact : michael.szypula@gmail.com
// License Information : Contact Developer to obtain license agreement.
// =================================================================================================       

package bubbletools.filesystem {
	
	public class BTFileObject implements IFileObject {

		private var fileView:BTFileView;
		                                  
		private var name:String;
		private var location:String;
		private var datasource:String;
		private var fileId:Number;
		private var type:String;   
		    
		
		public function setFileId(fId:Number):void {
			fileId = fId;
		}   
		                     
		public function getFileId():Number {
			return fileId;
		}  
		
		public function getByteSize():Number {
			
		}               
		
		public function BTFileObject(name, type, location, datasource, XYposition, fileID, myByteSize, myFileType, myFileSystem, myOwner) {

			this.myFileSystem = myFileSystem;
			this.fileObjectName = "file"+this.myFileSystem.fileCount;
			this.name = name;
			this.type = type;
			this.myFileType = myFileType;
			this.myByteSize = new Number(myByteSize);
			this.fileID = fileID;
			this.myOwner = myOwner;
			//
			this.location = location;
			this.datasource = datasource;
			this.XYposition = XYposition;
			this.windowIsAttached = false;
			this.isSelected = false;
			// process file type
			if (this.type == "folder") {
				this.frameObject = new frame(this.name, this, true);
			} else if ((this.type == "share") or (this.type == "drop")) {
				this.frameObject = new frame(this.name, this, true);
			} else if (this.type == "network") {
				this.frameObject = new frame(this.name, this, true);
			} else if ((this.type == "remote") or (this.type == "remoteDrop")) {
				myDebug("Added remote file : "+this.name);
				this.frameObject = new frame(this.name, this, false);
			}
			// select ICON graphic from Registry
			for (i=0; i<theRegistry.length; i++) {
				if (theRegistry[i].type == type) {
					theGraphic = theRegistry[i].iconGraphic;
					useInternal = theRegistry[i].usesInternalIcon;
				}
			}
			// create ICON object and attach this file
			if (this.XYposition == null) {
				this.XYposition = this.location.newDrop();
			}
			this.iconObject = new bubbleIcon(theGraphic, this.XYposition, this, "icon"+iconCount, useInternal);
			//
			if (this.location.isVisible) {
				this.iconObject.show();
			}
			iconCount++;
			this.location.attach(this);    
			}
			//
			file.prototype.open = openFile;
			file.prototype.select = selectFile;
			file.prototype.deselect = deselectFile;
			file.prototype.download = downloadThisFile;
			file.prototype.duplicateFromRemote = duplicateFromRemote;
			file.prototype.duplicateToRemote = duplicateToRemote;
			//
			function duplicateFromRemote(targetLocation, targetPoint) {
				_global.bubbleDesk.copyFileOnServer(this.datasource, this.myOwner, _global.bubbleDesk.currentUser.userName);
				_global.bubbleFileSystem.addFile(this.name, this.type, targetLocation, this.datasource, targetPoint, this.fileID, this.myByteSize, this.myFileType, _global.bubbleDesk.currentUser.userName);
			}
			function duplicateToRemote(remoteUser) {
				_global.bubbleDesk.copyFileOnServer(this.datasource, _global.bubbleDesk.currentUser.userName, remoteUser);
				sendDropItemInfo(this, remoteUser);
			}
			function openFile() {
				myDebug("Opening file :"+this.name+" of type "+this.type);
				if (this.type == "folder" or this.type == "share" or this.type == "network" or this.type == "remote" or this.type == "drop") {
					if (!this.windowIsAttached) {
						myDebug("No window attached.. creating new.");
						this.windowIsAttached = true;
						this.attachedWindow = new window(this.name, "frame");
						this.attachedWindow.show();
						this.attachedWindow.attachContents(this.frameObject);
						this.attachedWindow.setDraggable(true);
						this.attachedWindow.attachedResource = this;
					} else {
						myDebug("Window already attached - making visible  :"+this.attachedWindow.name);
						this.attachedWindow.show();
						this.attachedWindow.attachContents(this.frameObject);
						this.attachedWindow.setDraggable(true);
						this.attachedWindow.bringToFront();
					}
					if (this.type == "drop") {
						openDropBox();
					}
				} else if (this.type == "swf" or this.type == "jpg") {
					newWindow = new window(this.name, this.type);
					newWindow.show();
					newWindow.attachContents("users/"+this.myOwner+"/files/"+this.datasource);
					newWindow.setDraggable(true);
				} else if (this.type == "text") {
					newWindow = new window(this.name, "text");
					newWindow.show();
					newWindow.attachContents("users/"+this.myOwner+"/files/"+this.datasource);
					newWindow.setDraggable(true);
				} else if (this.type == "mp3") {
					newWindow = new window(this.name, "mp3");
					newWindow.show();
					newWindow.setSize(200, 170);
					newWindow.setResizeable(false);
					newWindow.setScrollable(false);
					newWindow.attachContents("users/"+this.myOwner+"/files/"+this.datasource);
					newWindow.setDraggable(true);
				} else if (this.type == "remoteDrop") {
					myDebug("Can't open others drop folders...");
				}
			}
			function downloadThisFile() {
				myDebug("Preparing Download...");
				if (this.type != "folder") {
					getURL("users/"+currentUser.userName+"/files/"+this.datasource, "_blank");
				}
			}
			function selectFile() {
				myDebug("Selecting file..");
				this.isSelected = true;
				this.myFileSystem.setSelectedFile(this);
			}
			function deselectFile() {
				this.isSelected = false;
				this.iconObject.deselect();
			}

	}
	
}  