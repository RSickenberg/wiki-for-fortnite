fastlane documentation
================
# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```
xcode-select --install
```

Install _fastlane_ using
```
[sudo] gem install fastlane -NV
```
or alternatively using `brew cask install fastlane`

# Available Actions
## iOS
### ios before_integration
```
fastlane ios before_integration
```

### ios after_integration
```
fastlane ios after_integration
```

### ios beta
```
fastlane ios beta
```
Push a new beta build to TestFlight
### ios release
```
fastlane ios release
```
Release a build to AppStore
### ios frame
```
fastlane ios frame
```
Frame some screenshots

----

## Mac
### mac beta
```
fastlane mac beta
```
Push a new beta build to TestFlight
### mac frame
```
fastlane mac frame
```
Frame some screenshots

----

This README.md is auto-generated and will be re-generated every time [fastlane](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
