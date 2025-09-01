import 'dart:developer';

import 'package:logger/logger.dart';

final logger = AppLogger();

class AppLogger {
  late final l = Logger(
    printer: HybridPrinter(
      _defaultPrinter,
      info: _infoPrinter,
      error: _errorPrinter,
      fatal: _errorPrinter,
    ),
    output: DeveloperConsoleOutput(),
  );

  final _defaultPrinter = PrettyPrinter(
    methodCount: 4,
    errorMethodCount: 4,
    dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
  );

  final _infoPrinter = PrettyPrinter(
    methodCount: 0,
    errorMethodCount: 0,
    noBoxingByDefault: true,
  );

  final _errorPrinter = PrettyPrinter(
    dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
    methodCount: 8,
  );

  /// The `info` level in logging is used to record informational messages that highlight the progress of the application at a coarse-grained level. These messages are typically used to indicate that the application is working as expected and to provide insights into the flow of the application.
  ///
  /// Here are some common uses of the `info` level:
  ///
  /// 1. **Startup and Shutdown Messages**: Indicating when the application starts and stops.
  /// 2. **Configuration Information**: Logging configuration settings or environment details.
  /// 3. **Major Milestones**: Recording significant events in the application, such as the completion of a major task or the start of a new phase.
  /// 4. **User Actions**: Logging actions taken by users, such as login attempts or data submissions.
  /// 5. **Periodic Status Updates**: Providing regular updates on the application's status or progress.
  void i(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    l.i(message, time: time, error: error, stackTrace: stackTrace);
  }

  /// The `debug` level is used to provide detailed information, typically of interest only when diagnosing problems.
  ///
  /// Here are some scenarios where you might use the `debug` level:
  ///
  /// 1. **Detailed Flow Information**: To trace the flow of execution through your code, especially in complex algorithms or processes.
  /// 2. **Variable Values**: To log the values of variables at various points in your code to understand how data is being transformed.
  /// 3. **Function Entry and Exit**: To log when functions or methods are entered and exited, which can help in understanding the control flow.
  /// 4. **Configuration Details**: To log configuration settings when the application starts, which can help in verifying that the application is using the correct settings.
  /// 5. **External API Calls**: To log requests and responses when interacting with external services, which can help in diagnosing issues related to external dependencies.
  /// 6. **Performance Metrics**: To log performance-related information, such as the time taken to execute certain blocks of code.
  void d(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    l.d(message, time: time, error: error, stackTrace: stackTrace);
  }

  /// The `warning` level in logging is used to indicate that something unexpected happened or indicative of some problem in the near future (e.g., ‘disk space low’). The software is still working as expected, but the situation might require attention soon. It's a way to alert developers or system administrators to potential issues that are not immediately critical but could become problematic if not addressed.
  ///
  /// Here are some typical use cases for the `warning` level:
  ///
  /// 1. **Deprecation Notices**: Indicating that a feature or API is deprecated and will be removed in future versions.
  /// 2. **Resource Limits**: Warning about approaching resource limits, such as low disk space or high memory usage.
  /// 3. **Configuration Issues**: Notifying about non-critical configuration issues that might affect performance or functionality.
  /// 4. **Recoverable Errors**: Situations where an error occurred but the system was able to recover and continue operating.
  void w(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    l.w(message, time: time, error: error, stackTrace: stackTrace);
  }

  /// The `error` level is used to indicate serious issues that have occurred in the application, but unlike the `fatal` level, these issues do not necessarily cause the application to terminate.
  /// The `error` level is intended for situations where the application has encountered a problem that needs to be addressed, but it can still continue running.
  ///
  /// Here are some scenarios where you might use the `error` level:
  ///
  /// 1. **Recoverable Errors**: When an error occurs that the application can recover from, but it still needs to be logged for further investigation. For example, failing to write to a log file but continuing to operate using an alternative logging mechanism.
  /// 2. **Failed Operations**: When a specific operation fails, such as a failed database query or an unsuccessful API call, but the application can continue with other operations.
  /// 3. **User Input Errors**: When invalid user input is received that cannot be processed, but the application can prompt the user to correct the input and try again.
  /// 4. **Resource Unavailability**: When a required resource, such as a file or network service, is temporarily unavailable, but the application can retry or use a fallback mechanism.
  /// 5. **Exception Handling**: When an exception is caught that indicates a significant problem, but the application has a way to handle it and continue running.
  void e(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    l.e(message, time: time, error: error, stackTrace: stackTrace);
  }

  /// The `fatal` level is used to indicate very severe error events that will presumably lead the application to abort.
  /// This level of logging is intended for situations where the application cannot continue running due to a critical failure.
  ///
  /// Here are some scenarios where you might use the `fatal` level:
  ///
  /// 1. **Unrecoverable Errors**: When an error occurs that the application cannot recover from, such as a failure to connect to a critical database or service.
  /// 2. **System Failures**: When a critical system component fails, such as running out of memory or disk space.
  /// 3. **Security Breaches**: When a security breach is detected that compromises the integrity of the application.
  /// 4. **Configuration Errors**: When essential configuration files or settings are missing or corrupted, preventing the application from starting.
  /// 5. **Unhandled Exceptions**: When an unhandled exception occurs that causes the application to crash.
  void f(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    l.f(message, time: time, error: error, stackTrace: stackTrace);
  }
}

/// Workaround as default output is broken on iOS builds.
///
/// Remove when https://github.com/flutter/flutter/issues/20663 is closed and the workaround is no longer needed.
class DeveloperConsoleOutput extends LogOutput {
  @override
  void output(OutputEvent event) {
    final buffer = StringBuffer();
    event.lines.forEach(buffer.writeln);
    log(buffer.toString());
  }
}
