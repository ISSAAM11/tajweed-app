import 'package:flutter/material.dart';
import 'package:html/parser.dart' as html;

class SimpleParser extends StatelessWidget {
  final String input;
  final TextStyle? style;

  const SimpleParser(this.input, {super.key, this.style});

  @override
  Widget build(BuildContext context) {
    // Parse HTML and extract plain text
    final parsedText = html.parseFragment(input).text;

    return Text(
      parsedText ?? '',
      textDirection: TextDirection.rtl,
      style: style ?? const TextStyle(fontSize: 18, fontFamily: 'UthmanicHafs'),
    );
  }
}
