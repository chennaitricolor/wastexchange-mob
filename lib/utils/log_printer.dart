import 'package:logger/logger.dart';

class SimpleLogPrinter extends LogPrinter {
  SimpleLogPrinter(this.className);

  final String className;
  @override
  void log(Level level, message, error, StackTrace stackTrace) {
    final color = PrettyPrinter.levelColors[level];
    final emoji = PrettyPrinter.levelEmojis[level];
    println(color('$emoji $className - $message'));
  }
}
