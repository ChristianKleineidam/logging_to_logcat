# logging_to_logcat

This package extends the [logging](https://pub.dev/packages/logging) package with
an extension that forwards log output to Android's Logcat. Invoke
`Logger.root.activateLogcat()` during startup to begin sending logs.

## Usage

```dart
import 'package:logging_to_logcat/logging_to_logcat.dart';
import 'package:logging/logging.dart';

Logger.root.activateLogcat();

final Logger log = Logger("MyLogger");
log.info("demo logline!");
```


## Documentation
Logger has a more fine-grained way of defining logging levels then Android. This plugin does the
following mappings:

FINEST -> VERBOSE  
FINER -> VERBOSE  
FINE -> VERBOSE  
CONFIG -> DEBUG  
INFO -> INFO  
WARNING -> WARNING  
SEVERE -> ERROR  
SHOUT -> ERROR  

Note that by default Logger silences messages under the level of INFO. If it's desired that all
Logging makes it to Logcat it's necessary to call:

```dart
Logger.root.level = Level.ALL;
```

## Building the Android example

The Android sample bundled with this plugin now uses Gradle 8.5 together with
the Android Gradle plugin 8.5.0. This toolchain supports running on **Java 21**,
so you can keep your `JAVA_HOME` pointing at a JDK 21 installation when
invoking `flutter build` or `flutter run`.

## Contributions
Especially, given that this is the first package I published on pub.dev I'm happy about any pointers of how it can be improved.
