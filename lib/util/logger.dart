import 'package:logger/logger.dart';
import 'package:wastexchange_mobile/util/log_printer.dart';

Level getLoggerLevel(String level) {
  switch (level) {
    case 'debug':
      return Level.debug;
    case 'info':
      return Level.info;
    case 'warning':
      return Level.warning;
    case 'error':
      return Level.error;
    default:
      return Level.error;
  }
}

Logger getLogger(String className) {
  return Logger(printer: SimpleLogPrinter(className));
}
