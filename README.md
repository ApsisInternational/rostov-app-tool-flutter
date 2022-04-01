# Camera Plugin

A Flutter plugin for iOS and Android allowing to use ApsisOne's App Tool mobile SDK.

|                | Android | iOS      |
|----------------|---------|----------|
| **Support**    | SDK ??? | iOS 11+  |

## Features

* Automatic screenView events collecting
* Create and send custom events
* Location collecting
* Create and sent custom location events

## Installation

First, add `apsis_one` as a [dependency in your pubspec.yaml file](https://flutter.dev/using-packages/).

### iOS

Location collecting: To be able to collect location youu should provide descriptions of usage.

Add two rows to the `ios/Runner/Info.plist`:

* one with the key `Privacy - Location Always and When In Use Usage Description` and a usage description.
* and one with the key `Privacy - Location When In Use Usage Description` and a usage description.

If editing `Info.plist` as text, add:

```xml
<key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
<string>your usage description</string>
<key>NSLocationWhenInUseUsageDescription</key>
<string>your usage descriptiong</string>
```

Moreover to collect device's location in background location background mode must be added to the application's target:

Target -> Signing & Capabilities -> Background modes -> Location updates

If editing `Info.plist` as text, add:

```xml
<key>UIBackgroundModes</key>
<array>
	<string>location</string>
</array>
```

### Android

TODO: Describe android quick start tips and some minimum requirements


### Provide route observing for App Tool

To be able to collect screenView events automatically, you have to pass the ApsisOne NavigationObserver in the navigatorObservers argument to the MaterialApp constructor:
```dart
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorObservers: [ApsisOne.oneRouteObserver],
    );
  }
```

### Example

For a usage example see [here](https://github.com/ApsisInternational/rostov-app-tool-flutter/tree/main/example).