import 'dart:async';

import 'package:flutter/material.dart';
import 'package:logcat/logcat.dart';
import 'package:logger_to_logcat/logger_to_logcat.dart';
import 'package:logging/logging.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _logDisplayText = '';

  static const String FINE_MESSAGE = "This is a fine message";
  static const String CONFIG_MESSAGE = "This is a config message";
  static const String INFO_MESSAGE = "This is a info message";
  static const String WARNING_MESSAGE = "This is a warning message";
  static const String ERROR_MESSAGE = "This is a error message";

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {}

  Future<void> playWithLogcat() async {
    var text = await getLogtext();

    setState(() {
      _logDisplayText = text;
    });
  }

  static Future<String> getLogtext() async {
    String oldLogs = await Logcat.execute();
    Logger.root.activateLogcat();
    Logger.root.level = Level.ALL;

    Logger log = Logger("ExampleLogger");
    log.fine(FINE_MESSAGE);
    log.config(CONFIG_MESSAGE);
    log.info(INFO_MESSAGE);
    log.warning(WARNING_MESSAGE);
    log.severe(ERROR_MESSAGE);

    String newLogs = await Logcat.execute();
    var diffText = newLogs.replaceAll(oldLogs, "");
    diffText = diffText.replaceAllMapped(RegExp(r"(\d\d-\d\d)"), (match) {
      return '\n\n${match.group(0)}';
    });

    return diffText;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Writing/reading from Logcat'),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Text(
                      '$_logDisplayText',
                      textScaleFactor: 1.5,
                    ),
                  ),
                ),
                SizedBox(
                  height: 32.0,
                ),
                OutlinedButton(
                  onPressed: playWithLogcat,
                  child: Text("Play with 😼 Logcat 🐈"),
                  style:
                      OutlinedButton.styleFrom(minimumSize: Size(50.0, 50.0)),
                ),
                SizedBox(
                  height: 64.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
