import 'package:flutter/material.dart';
import 'package:html/parser.dart' as html_parser;
import 'package:html/dom.dart' as dom;
import 'package:tajweed_ai/src/app/design/styles/tajweed_styles.dart';
import 'package:tajweed_ai/src/database/app_database.dart';

class QuranParagraph extends StatelessWidget {
  final List<List<WordRow>> ayahs;
  const QuranParagraph({super.key, required this.ayahs});

  @override
  Widget build(BuildContext context) {
    const TextStyle baseTextStyle = TextStyle(
      fontSize: 25,
      fontFamily: 'UthmanicHafsV18',
      color: Colors.black87,
      height: 1.8,
    );

    // Combine all words into a single HTML string
    final paragraphHtml = ayahs
        .map((List<WordRow> ayah) => ayah.map((word) => word.text_).join(' '))
        .toList()
        .join(' ');

    final document = html_parser.parse('<span>$paragraphHtml</span>');
    final spans = _parseNode(document.body!.firstChild!, baseTextStyle);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 10),
      child: RichText(
        text: TextSpan(children: spans),
        textAlign: TextAlign.justify,
        textDirection: TextDirection.rtl,
      ),
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
