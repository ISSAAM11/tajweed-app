import 'dart:developer';

abstract final class Debugger {
  static void black(dynamic text) => log('\x1B[30m$text\x1B[0m');

  static void red(dynamic text) => log('\x1B[31m$text\x1B[0m');

  static void orange(dynamic text) => log('\x1B[33m$text\x1B[0m');

  static void green(dynamic text) => log('\x1B[32m$text\x1B[0m');

  static void yellow(dynamic text) => log('\x1B[33;1m\x1B[5m$text\x1B[0m');

  static void blue(dynamic text) => log('\x1B[34m$text\x1B[0m');

  static void magenta(dynamic text) => log('\x1B[35;1m\x1B[5m$text\x1B[0m');

  static void cyan(dynamic text) => log('\x1B[36m$text\x1B[0m');

  static void white(dynamic text) => log('\x1B[37m$text\x1B[0m');
}
