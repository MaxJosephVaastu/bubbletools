// bubbletools.* ===============================================================================
// BubbleTools™ Web Application and User Interface Component Architecture for Actionscript 3
// ©2007 Michael Szypula.  Any modifications to this file must keep this license block intact.
// Developer : Michael Szypula
// Contact : michael.szypula@gmail.com
// License Information : Contact Developer to obtain license agreement.
// =================================================================================================    

package bubbletools.filesystem {              
	                              
	import bubbletools.core.async.XmlLoader;
	import bubbletools.util.Debug;
	
	private var selectedFile:BTFileObject;
	
	private static var _instance:BTFileSystem;
	private static var _FSML:String;
	
	public class BTFileSystem extends Requesting {   
		
		private var fileCount:Number = 0;
		private var byteCount:Number = 0;
		private var files:Array;     
		private var selectedFile:IFileObject;        
		
		public static function init(FSML:String):void { 
			_FSML = FSML;
			_instance = new BTFileSystem();
		}   

		public function BTFileSystem() { 
        	files = new Array();
			startLoad();
		}          
                   
		// Load XML representing a file hierarchy
		
		public function startLoad():void {
			if(_FSML) {
				var myLoader:XmlLoader = new XmlLoader();
				setHandler(FSMLLoaded);
				setError(FSMLFailed);
				myLoader.setParams(_FSML, this);
				myLoader.startLoad();
			} else {
				Debug.output(this, "No FSML file was specified to load.");
			}
		}
		
		public function FSMLFailed():void {
		   
		}
		
		// Parse FSML
		
		public function FSMLLoaded(xmlData:XML):void {
			Debug.output(this, "FSML loaded, begin parse.");
			
		}     
		
		// Filesystem functions
		
		public function setSelectedFile(f:IFileObject) {
			if(f != selectedFile) {
				selectedFile.deselect();
			   	selectedFile = f;
			}   
			Debug.output(this, "selected file "+f.name);
		 }
		
	    public function addFile(f:IFileObject):void {   
			
			if (f.getFileId() == undefined) {
				f.setFileId(files.length);
			}                   
			
			fileCount = files.push(f);
			byteCount += f.getByteSize();
		}                      
		        
		
		public function removeFile(f:IFileObject):void {   
			
			var fileToDelete = null;
			if (theFileToDelete != null) {
				fileToDelete = theFileToDelete;
			} else {
				fileToDelete = this.selectedFile;
				this.selectedFile = null;
			}
			myDebug("Deleting File : "+fileToDelete.name);
			// kill file on server
			if (fileToDelete.type != "folder") {
				if (fileToDelete.myOwner == bubbleDesk.currentUser.userName) {
					myDebug("Removing file from server..");
					deleteButton.myButtonClip.backing.gotoAndStop("busy");
					deleteButton.myButtonClip.button.enabled = false;
					var eraseURL = "eraseFile.php";
					var dataToSend = new LoadVars();
					dataToSend.fileToErase = "users/"+currentUser.userName+"/files/"+fileToDelete.datasource;
					dataToSend.onLoad = function(success) {
						if (success) {
							bubbleDesk.deleteButton.myButtonClip.backing.gotoAndStop(1);
							bubbleDesk.deleteButton.myButtonClip.button.enabled = true;
						} else {
						}
					};
					dataToSend.sendAndLoad(eraseURL, dataToSend, "POST");
				}
			} else {
				myDebug("Erasing subfolders");
				var folderContents = fileToDelete.frameObject.attachedFiles;
				for (var j = 0; j<folderContents.length; j++) {
					this.removeFile(folderContents[j]);
				}
			}
			// search icons
			var iconArrayID = null;
			fileToDelete.iconObject.theIconClip.removeMovieClip();
			for (var j = 0; j<allicons.length; j++) {
				var compareIcon = allicons[j];
				if (fileToDelete.iconObject == compareIcon) {
					iconArrayID = j;
					myDebug("Located icon in icons array");
				}
			}
			allicons.splice(iconArrayID, 1);
			// search windows
			var windowArrayID = null;
			if (fileToDelete.windowIsAttached) {
				fileToDelete.attachedWindow.myWindowClip.removeMovieClip();
				for (var j = 0; j<allwindows.length; j++) {
					var compareWindow = allwindows[j];
					if (fileToDelete.attachedWindow == compareWindow) {
						windowArrayID = j;
						myDebug("Located icon in icons array");
					}
				}
			}
			allwindows.splice(windowArrayID, 1);
			// search filesystem
			var fileArrayID = null;
			for (var j = 0; j<this.files.length; j++) {
				var compareFile = this.files[j];
				if (fileToDelete == compareFile) {
					fileArrayID = j;
					myDebug("Located file in files array");
				}
			}
			this.files.splice(fileArrayID, 1);
			//
			fileToDelete.parentFrame.detach(fileToDelete);
		}       

		}                 

}
     