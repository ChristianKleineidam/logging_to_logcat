import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logger_to_logcat/logger_to_logcat.dart';

void main() {
  const MethodChannel channel = MethodChannel('logger_to_logcat');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await LoggerToLogcat.platformVersion, '42');
  });
}
