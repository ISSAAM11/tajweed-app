import 'package:flutter/material.dart';
import 'package:html/parser.dart' as html_parser;
import 'package:html/dom.dart' as dom;
import 'package:tajweed_ai/src/app/design/styles/tajweed_styles.dart';
import 'package:tajweed_ai/src/database/app_database.dart';

class QuranLineText extends StatelessWidget {
  final List<WordRow> lineWords;
  final bool isCentered;

  const QuranLineText({
    super.key,
    required this.lineWords,
    this.isCentered = false,
  });

  @override
  Widget build(BuildContext context) {
    const TextStyle baseTextStyle = TextStyle(
      fontSize: 19,
      fontFamily: 'UthmanicHafsV18',
      color: Colors.black87,
      height: 1.75,
    );

    if (lineWords.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 13.0, vertical: 2),
      child: _buildLineWithSpacing(lineWords, baseTextStyle),
    );
  }

  Widget _buildLineWithSpacing(List<WordRow> words, TextStyle baseStyle) {
    final wordWidgets = <Widget>[];

    for (int i = 0; i < words.length; i++) {
      final word = words[i];
      final document = html_parser.parse('<span>${word.text_}</span>');
      final spans = _parseNode(document.body!.firstChild!, baseStyle);

      wordWidgets.add(
        RichText(
          text: TextSpan(children: spans),
          textDirection: TextDirection.rtl,
        ),
      );

      if (isCentered) {
        if (i < words.length - 1) {
          wordWidgets.add(const Text(' '));
        }
      } else {
        // Justified lines use flexible spacing
        if (i < words.length - 1) {
          wordWidgets.add(const Spacer());
        }
      }
    }

    return Row(
      mainAxisAlignment: isCentered
          ? MainAxisAlignment.center
          : MainAxisAlignment.spaceBetween,
      textDirection: TextDirection.rtl,
      children: wordWidgets,
    );
  }

  List<TextSpan> _parseNode(dom.Node node, TextStyle baseStyle) {
    if (node.nodeType == dom.Node.TEXT_NODE) {
      return [TextSpan(text: node.text, style: baseStyle)];
    }
    if (node.nodeType == dom.Node.ELEMENT_NODE) {
      final element = node as dom.Element;
      final spans = <TextSpan>[];
      if (element.localName == 'rule') {
        final ruleClass = element.attributes['class'] ?? '';
        final tajweedColor = tajweedStyleMap[ruleClass]?.color;
        final styledText = baseStyle.copyWith(color: tajweedColor);
        for (var child in element.nodes) {
          spans.addAll(_parseNode(child, styledText));
        }
      } else {
        for (var child in element.nodes) {
          spans.addAll(_parseNode(child, baseStyle));
        }
      }
      return spans;
    }
    return [];
  }
}
