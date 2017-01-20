<p align="center">
<img src="https://raw.githubusercontent.com/realm-demos/realm-loginkit/master/screenshot.jpg" width="500" style="margin:0 auto" />
</p>

# Realm LoginKit

Realm LoginKit is a generic login view controller for iOS using the Realm Mobile Platform.

It provides a form interface to allow users to log in, or even sign up for the first time with a Mobile Platform account.

# Features

* Fully adaptive between iPhone and iPad size classes
* Provides easy swapping between logging in, and signin up for the first time,
* Light & Dark Themes: For light apps (like Realm Draw) as well as dark apps (like Relalm Tasks)
* Background can either be opaque, or translucent.
* Can be imported and used in Objective-C.

# Sample Code

## Swift

```swift

// Create the object
let loginController = LoginViewController(style: .lightTranslucent) // init() also defaults to lightTranslucent

// Configure any of the inputs before presenting it
loginController.serverURL = "localhost"

// Set a closure that will be called on successful login
loginController.loginSuccessfulHandler = { user in
	// Provides the successfully authenticated SyncUser object
}

```

## Objective-C

```objc
// Create the object
RLMLoginViewController *loginController = [[RLMLoginViewController alloc] initWithStyle:LoginViewControllerStyleLightTranslucent];

// Configure any of the inputs before presenting it
loginController.serverURL = @"localhost";

// Set a closure that will be called on successful login
loginController.loginSuccessfulHandler = ^(RLMSyncUser *user) {
	// Provides the successfully authenticated RLMSyncUser object
};

```

# Using the Sample App

The Realm LoginKit has several dependencies (namely, Realm itself) and these dependencies are managed via CocoaPods.

When trying to run the example project for the first time, make sure you have CocoaPods installed and run `pod install`
on the directory to set it up properly.

# Technical Requirements

iOS 9.0 and above

# License

Realm LoginKit is licensed under the Apache license. See the LICENSE file for details.
