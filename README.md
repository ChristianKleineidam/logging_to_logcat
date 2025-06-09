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
log.info('demo logline!');
```

## Development Setup

Run `tool/setup.sh` to install Flutter (if necessary) and fetch this package's
dependencies before executing tests or examples:

```bash
bash tool/setup.sh
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

## Contributions
Especially, given that this is the first package I published on pub.dev I'm happy about any pointers of how it can be improved. 
