import 'package:flutter/material.dart';
import 'package:html/parser.dart' as html_parser;
import 'package:html/dom.dart' as dom;
import 'package:tajweed_ai/src/app/design/styles/tajweed_styles.dart';
import 'package:tajweed_ai/src/database/app_database.dart';

class QuranLineText extends StatelessWidget {
  final List<WordRow> lineWords;
  final bool isCentered;
  final Function(int ayahNumber, Offset position)? onAyahTap;
  final int? selectedAyah;

  const QuranLineText({
    super.key,
    required this.lineWords,
    this.isCentered = false,
    this.onAyahTap,
    this.selectedAyah,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final responsiveVerticalPadding = screenHeight * 0.0035;
    final responsiveHorizentalPadding = screenWidth * 0.035;
    final responsivefontSize = screenWidth * 0.046;
    final responsiveTextHeight = screenHeight * 0.002;

    TextStyle baseTextStyle = TextStyle(
      fontSize: responsivefontSize,
      fontFamily: 'UthmanicHafsV17',
      fontWeight: FontWeight.w600,
      color: Color.fromARGB(183, 0, 0, 0),
      height: responsiveTextHeight,
    );

    if (lineWords.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: responsiveHorizentalPadding,
        vertical: responsiveVerticalPadding,
      ),
      child: _buildLineWithSpacing(lineWords, baseTextStyle),
    );
  }

  Widget _buildLineWithSpacing(List<WordRow> words, TextStyle baseStyle) {
    final wordWidgets = <Widget>[];

    for (int i = 0; i < words.length; i++) {
      final word = words[i];
      final isSelected = selectedAyah == word.ayah;
      final highlightColor = isSelected
          ? Colors.amber.withValues(alpha: 0.3)
          : Colors.transparent;

      final document = html_parser.parse('<span>${word.text_}</span>');
      final spans = _parseNode(document.body!.firstChild!, baseStyle);

      wordWidgets.add(
        GestureDetector(
          onTapDown: (details) {
            if (onAyahTap != null) {
              onAyahTap!(word.ayah, details.globalPosition);
            }
          },
          child: Container(
            decoration: BoxDecoration(
              color: isSelected
                  ? Colors.amber.withValues(alpha: 0.3)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(4),
            ),
            padding: EdgeInsets.symmetric(horizontal: 2, vertical: 1),
            child: RichText(
              text: TextSpan(children: spans),
              textDirection: TextDirection.rtl,
            ),
          ),
        ),
      );

      if (isCentered) {
        if (i < words.length - 1) {
          wordWidgets.add(const Text(' '));
        }
      } else {
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
