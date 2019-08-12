import 'package:logger/logger.dart';
import 'package:wastexchange_mobile/util/log_printer.dart';

Logger getLogger(String className) {
  return Logger(printer: SimpleLogPrinter(className));
}
