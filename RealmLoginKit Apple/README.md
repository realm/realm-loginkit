# Realm LoginKit (iOS Version)

This is the iOS version of Realm LoginKit. It has been designed to be dropped into iOS projects and presented modally over
the landing view controller of any app using the Realm Mobile Platform.

# Features

* Fully adaptive between iPhone and iPad size classes
* Provides easy swapping between logging in, and signin up for the first time,
* Light & Dark Themes: For light apps (like Realm Draw) as well as dark apps (like Realm Tasks)
* Background can either be opaque, or translucent.
* Can be imported and used in Objective-C.

# Installation

## Prerequisites

This app uses [Cocoapods](https://www.cocoapods.org) to set up the project's 3rd party dependencies. Installation can be directly (from instructions at the Cocapods site) or alternatively through a package management system like [Homebrew](brew.sh/).

### Realm Mobile Platform

This application demonstrates features of the [Realm Mobile Platform](http://lrealm.io) and needs to have a working instance of the Realm Object Server available to make tasks, and other data available between instances of the Fieldwork app. The Realm Mobile Platform can be downloaded from [Realm Mobile Platform](http://realm.io) and exists in two forms, a ready-to-run macOS version of the server, and a Linux version that runs on RHEL/CentOS versions 6/7 and Ubuntu as well as several Amazon AMIs and Digital Ocean Droplets. The macOS version can be run with the Fieldwork right out of the box; the Linux version will require access to a Linux server.


### 3rd Party Modules

The following modules will be installed as part of the CocoaPods setup:

- [Realm](https://realm.io)  The main line Realm bindings for Cocoa/ObjC
- [TORoundedTableView](https://github.com/TimOliver/TORoundedTableView)  subclass of UITableView that styles it like Settings.app on iPad




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
