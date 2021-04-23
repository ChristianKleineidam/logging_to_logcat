# logging_to_logcat

This package extends the [logging](https://pub.dev/packages/logging)-package with the functionality
to deliver it's logs to Android's [Logcat](https://developer.android.com/studio/debug/am-logcat).

## Usage

After adding the package it's easy to instruct Logger to send it's logging data to Android's Logcat:

```dart
import 'package:logging_to_logcat/logging_to_logcat.dart';

Logger.root.activateLogcat();
```

## Documentation
Logger has a more fine-grained way of defining logging levels then Android. This plugin does the
following mappings:

SHOUT -> ERROR  
SEVERE -> Error  
WARNING -> WARNING
INFO -> INFO
CONFIG -> DEBUG
FINE -> VERBOSE
FINER -> VERBOSE
FINEST -> VERBOSE

Note that by default Logger silences messages under the level of INFO. If it's desired that all
Logging makes it to Logcat it's necessary to call:

```dart
Logger.root.level = Level.ALL;
```

