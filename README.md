## Bug Fix History

 - **Flutter Bugs and Features**:
	 - 
	 - **Camera page Completeness:** 
		 - Camera page has been completed, the implementation wasn't the best, however my intention was fixing the current state and make the page functional.
		 - iOS app was missing privacy description for camera and microphone in Info.plist. Missing items have been added.
		 - I added extra item to handle the camera state make sure to deallocate the camera resource when user sends the app to background and resume the camera when user comes back to the app.
	 - **Page state persistency:**
		 - There are multiple ways to implement this . For example by using global key, or switch to page controller / page views, etc. However, my main aim was to make it working with least amount of changes.
		 - Some widgets were stateless and were converted to stateful to hold state.
	 - **Http page having long text**
		 - The result has been wrapped under SingleChildScrollView in order to allow user scroll the content.
		
 - **iOS Bugs**:
	 - 
	  - **Get Device name**
		  Get device name is working fine now. However, due to privacy reasons access to Phone's name is not allowed from iOS 16+ and the result is generic name.
	- **On NavBar left-button-tap incorrect animation**
		- This is due to incorrect implementation of the navigation from the begining, proper implementation requires upgrading it to Navigator 2.0 or PageController. 
		 - In order to fix this with minimal changes the fix was done by updating navigator animation.

 - **Android Bugs**:
	 - 
	  - **Get Device name is triggered by all method calls**
		  Method name filter has been applied.

 - **Other bug fix and improvements**:
	 - 
	 - Added safety control logic to prevent duplicated taps and unexpected issues during image captures
	 -	Siri shortcut button was not functioning. The logic has been uncommented and fixed. You can add the shortcut "Open Http page" and Siri will open the http page inside the app.
	 - Add native call listener to flutter side to respond to Siri triggers.
	 - Reference inside pages included package name which are not the best, the package name from local file references have been removed. (best practice)
	 - Most of the code warnings have been cleaned up.




## roadvault_interview_sandbox

A test app for conducting technical interviews

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.