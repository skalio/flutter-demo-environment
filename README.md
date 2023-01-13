# Environment Demo

A demo project that shows a way to separate test and production environments in a Flutter project.

# TL;DR

This project demonstrates how to use a test environment when developing, debugging and testing your app. It also shows how to easily release a production app that uses a different in-app environment as well as a different binary name, bundle ID and more on all of the following platforms:

- web
- macOS
- Windows
- Linux
- iOS
- Android

# Getting Started

In order to make use of this demo project, you need to be accustomed to multi-plaform Flutter development. This project is ready to run on all of the platforms above.

## Building and running the app in test mode

Test mode means that your app is configured as follows:

- Connects to a test backend
- Uses a test bundle ID / application ID
- Uses an executable file name with clearly marks it as a test binary
- Stores its local configuration settings in a test area, different from production use
- Registers a protocol handler (for starting a desktop app from a url) that is different from production use
- Registers universal links (So your mobile app is opened when a user clicks a link representing your web app) which are different from production use
- Registers credential handling that is different from production use

The project is running and building a test application per default. So just run the regular flutter command and choose the device:

`flutter run`

You now have a client running that is called _EnvironmentDemoTest_ which shows a test banner in the top left corner.
If you click on the little plus, an api call to a sample "test" backend is done and the result is being displayed.
(The test backend gives facts abouts cats 🐈)

If you want to build a macOS test app, just run

`flutter build macos`

You may also notice that the Application file name is _EnvironmentDemoTest.app_
This works for all other platforms as well!

## Building and running the app in production mode

Switching from test mode to production mode is separated into two steps:

### Step 1: Providing a parameter to use a different app internal environment

For everything that needs to be adapted _within_ your dart code, you may use a variable within your `Environment`.
Please take a look at **environment.dart** - it is fairly well documented and includes example of which variables need to differ between test and production mode. This demo project only makes use of a differing backend host name.

If you want to run your app using a production environment do this:

`flutter run --dart-define=environment=production`

You now have a client running that is still called _EnvironmentDemoTest_ but it no longer shows a test banner in the top left corner.
If you click on the little plus, an api call to a sample "production" backend is done and the result is being displayed.
(The production backend gives proposals about interesting things to do 🏖️)

Why is the app still called EnvironmentDemoTest? That's because The application name is a setting that is not dependent on your dart code but instead defined in your platform dependent configuration files. Check the next step!

### Step 2: Converting the project into release mode

Since there is no Flavor support in Flutter for macOS we actually need to change files to adapt certain platform specific settings which should differ between a test app and a realeasable production app.

I have come up with a very pragmatic approach which honors the fact that most of the times a developer builds an app, it will be for our all so beloved develop-build-test cycle. This means the test scenario is way more often used than the production scenario!

So my approach advises to leave the git repo in a state where it always builds test applications. In order to convert your repo to a release candidate, you should create a _staging_ (or _stable_) branch and then (and only then) run the following command:

`./change2production.sh`

This command runs on macOS and Linux, but changes the plaform settings for _all_ plattforms. 
Sorry, no script for Windows developers. I'll gladly accept a PR to fix that.

This command changes files in this repo! It replaces all test strings with their production counterparts in the platform dependent sub directories:

- ios
- macos
- web
- windows
- android
- linux

Here is a table that shows the replacements:

| test value | production value | explanation |
| ------ | ------ | ------ |
| EnvironmentDemoTest | EnvironmentDemo | Executable name |
| environmentdemotest | environmentdemo | protocol scheme to call app from browser |
| com.environmentdemo.dev | com.environmentdemo.app | bundle id (macOS/iOS) app id (Android) |
| applinks:app.environmentdemo.dev | applinks:app.environmentdemo.com | universal links |
| webcredentials:app.environmentdemo.dev | webcredentials:app.environmentdemo.com | web credentials |

**If** you are on a branch that has been created for releasing a version of your app, then you may commit the changes introduced by this script. Make your your `main`/`master` branch stays on the test configuration.

## Building a production release candidate

In your release branch where you have run `change2production.sh` you may now create a production binary by using the environment parameter:

`flutter build macos --dart-define=environment=production`

This works for all other platforms as well! The newly build binary can be uploaded to the app store. You only need to adapt the version number and the build number where applicable.
