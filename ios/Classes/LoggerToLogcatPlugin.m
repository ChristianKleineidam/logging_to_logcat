#import "LoggerToLogcatPlugin.h"
#if __has_include(<logger_to_logcat/logger_to_logcat-Swift.h>)
#import <logger_to_logcat/logger_to_logcat-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "logger_to_logcat-Swift.h"
#endif

@implementation LoggerToLogcatPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftLoggerToLogcatPlugin registerWithRegistrar:registrar];
}
@end
