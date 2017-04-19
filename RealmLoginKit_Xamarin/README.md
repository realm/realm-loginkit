# Realm LoginKit for Xamarin
> A general purpose account login user interface for apps implementing the Realm Mobile Platform.

Inspiration for UI features from [The God Login](https://blog.codinghorror.com/the-god-login/) article on designing a login page and [Nick Babich on Mobile Form Usability](https://uxplanet.org/mobile-form-usability-2279f672917d).

## Work in Progress

At this stage the Xamarin Forms loginkit is very much a work-in-progress and is **not** a release version.

The following list represents intended features. In the main Features section, copied from the parent readme, there are also items marked with (TBD) indicating they are To Be Done.


* replace Readme image with images from Xamarin version

### Planned Features
* Isolated viewmodel - currently just using class directly
* Abstraction of viewmodel and Realm login behind interfaces, so people can use kit just as a UI kit.
* User hooks for subscribe to password entry and provide quality feedback
* Optional switch to show password text - possibly do with alternative fields if cannot toggle style.
* Optional switch for in-field hints.
* User hooks to validate email.
* Options via a struct.
* Optional specification of Azure and other auth buttons.
* Allow for custom saving of details (maybe via viewmodel interface).
* Optional forgot password button.
* Optional remember settings including remember password.
* Native UI iOS version based on Draw.
* Native UI Android version based on Draw.
* Duplicate of example app to use NuGet, initial one uses projects directly.
* Doc walkthrough recreating example app using NuGet.

### Undecided
* Should modal presentation be part of the kit and how can users customise?
* What does navigation look like including loginkit?
* How does using it in native UI apps change compared to Forms?
* How to abstract credentials store and provide good default.
* Can the user inject/customise the loginkit UI even if just by providing an overloaded page? ie: can they clone our UI and use the viewmodel to still save a lot of time?

<p align="center">
<img src="https://raw.githubusercontent.com/realm-demos/realm-loginkit/master/screenshot.jpg" width="500" style="margin:0 auto" />
</p>

Realm LoginKit is a UI framework that provides a fully featured login screen for apps that make use of the Realm Mobile Platform.

It has been designed to be easily dropped into existing app codebases, and to provide a fully featured interface allowing users to either log in, or register new accounts in that app.

## Features
* Light & dark themes for light apps like Realm Draw, and dark apps like Realm Tasks. (TBD)
* Fully adaptive to both smartphone, and tablet screen sizes.
* Easy swapping between 'log in' and 'sign up' modes.
* Optional settings to hide the server URL and 'remember me' form fields.
* The ability to remember username and passwords on subsequent app launches.

## Versions & Requirements


## Third Party Dependencies

### Xamarin Forms
* AcrDialogs 

## Example Code

**TBD**

## Setting up the Demo App
**TBD**

# Installation

### iOS
#### NuGet
**TBD**

#### Manually

**TBD**

# Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for more details!

This project adheres to the [Contributor Covenant Code of Conduct](https://realm.io/conduct/). By participating, you are expected to uphold this code. Please report unacceptable behavior to [info@realm.io](mailto:info@realm.io).

# License

Realm LoginKit is licensed under the Apache license. See the LICENSE file for details.
