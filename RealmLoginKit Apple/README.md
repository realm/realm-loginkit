<p align="center">
<img src="https://raw.githubusercontent.com/realm-demos/realm-loginkit/master/screenshot.jpg" width="500" style="margin:0 auto" />
</p>

# Realm LoginKit (iOS Version)

This is the iOS version of Realm LoginKit. It has been designed to be dropped into iOS projects and presented modally over
the landing view controller of any app using the Realm Mobile Platform.

# Features

* Fully adaptive between iPhone and iPad size classes
* Provides easy swapping between logging in, and signing up for the first time,
* Light & Dark Themes: For light apps (like Realm Draw) as well as dark apps (like Realm Tasks)
* Background can either be opaque, or translucent.
* Can be imported and used in Objective-C.
* Remembers previous login details via `NSUserDefaults`.

# Installation

## Prerequisites

This framework requires [Cocoapods](https://www.cocoapods.org) to manage its external dependencies, and these must be installed before it can be built. 

For instructions on how to install CocoaPods, visit the [Getting Started](https://guides.cocoapods.org/using/getting-started.html) guide on the CocoaPods website.

Once CocoaPods is installed, navigate to this directory in Terminal.app, and run `pod install` to set up these dependencies.

### Realm Mobile Platform

This framework demonstrates features of the [Realm Mobile Platform](https://realm.io/products/realm-mobile-platform/) and needs to have a working instance of the Realm Object Server available in order to function properly.

A copy of the Realm Mobile Platform can be [downloaded and run locally on macOS](https://realm.io/docs/get-started/installation/mac/), available on the Realm website.

### Third Party Modules

The following modules will be installed as part of the CocoaPods installation process:

- [Realm](https://realm.io) - The Objective-C version of Realm. Realm Swift wasn't used as it would add unnecessary complexity to Objective-C projects.
- [TORoundedTableView](https://github.com/TimOliver/TORoundedTableView) - A subclass of `UITableView` that adds rounded corners, like Settings.app on iPad.

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

# Technical Requirements

iOS 9.0 and above
