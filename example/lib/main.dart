import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:logging_to_logcat/logging_to_logcat.dart';
import 'package:logging_to_logcat_example/log_cat_bloc.dart';

const String FINE_MESSAGE = "This is a fine message";
const String CONFIG_MESSAGE = "This is a config message";
const String INFO_MESSAGE = "This is a info message";
const String WARNING_MESSAGE = "This is a warning message";
const String ERROR_MESSAGE = "This is a error message";

Future initLogging() async {
  Logger.root.activateLogcat();
  Logger.root.level = Level.ALL;
}

Future addLog() async {
  Logger log = Logger("ExampleLogger");
  log.fine(FINE_MESSAGE);
  log.config(CONFIG_MESSAGE);
  log.info(INFO_MESSAGE);
  log.warning(WARNING_MESSAGE);
  log.severe(ERROR_MESSAGE);
}

void main() {
  initLogging();

  runApp(BlocProvider<LogCatBloc>(
    create: (context) => LogCatBloc(),
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {}

  Future<void> playWithLogcat() async {
    addLog();
    setState(() {
      //_logDisplayText = text;
    });
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
                  child: BlocBuilder<LogCatBloc, LogCatState>(
                    builder: (context, state) {
                      List<Widget> widgetList =
                          state.logEntryList.map((String item) {
                        return ListTile(
                            title: Text(item, style: TextStyle(fontSize: 20)));
                      }).toList();

                      return ListView.builder(
                          itemCount: state.logEntryList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return widgetList[index];
                          });
                    },
                  ),
                ),
                SizedBox(
                  height: 32.0,
                ),
                OutlinedButton(
                  onPressed: playWithLogcat,
                  child: Text(
                    "Play with 😼 Logcat 🐈",
                    style: TextStyle(fontSize: 20),
                  ),
                  style:
                      OutlinedButton.styleFrom(minimumSize: Size(60.0, 60.0)),
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
