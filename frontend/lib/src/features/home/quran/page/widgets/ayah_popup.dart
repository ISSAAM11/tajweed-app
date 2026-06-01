// ayah_popup_widget.dart
import 'package:flutter/material.dart';

class AyahPopupWidget extends StatelessWidget {
  final int ayahNumber;
  final Offset tapPosition;
  final GlobalKey parentKey;
  final VoidCallback onDismiss;
  final VoidCallback? onCopy;
  final VoidCallback? onBookmark;
  final VoidCallback? onShare;
  final VoidCallback? onPlay;

  const AyahPopupWidget({
    super.key,
    required this.ayahNumber,
    required this.tapPosition,
    required this.parentKey,
    required this.onDismiss,
    this.onCopy,
    this.onBookmark,
    this.onShare,
    this.onPlay,
  });

  @override
  Widget build(BuildContext context) {
    final renderBox =
        parentKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return SizedBox.shrink();

    final screenSize = MediaQuery.of(context).size;
    final screenHeight = MediaQuery.of(context).size.height;
    final parentPosition = renderBox.localToGlobal(Offset.zero);
    final parentSize = renderBox.size;

    const popupWidth = 190.0;
    const popupHeight = 40.0;
    const margin = 16.0;

    double top = parentPosition.dy - popupHeight - screenHeight * 0.12;
    double left = tapPosition.dx - (popupWidth / 2);

    // Prevent left overflow
    if (left < margin) left = margin;

    // Prevent right overflow
    if (left + popupWidth > screenSize.width - margin) {
      left = screenSize.width - popupWidth - margin;
    }

    // Prevent top overflow - show below if needed
    if (top < margin) {
      top = parentPosition.dy + parentSize.height + 10;
    }

    // Prevent bottom overflow
    if (top + popupHeight > screenSize.height - margin) {
      top = screenSize.height - popupHeight - margin;
    }

    return Positioned(
      left: left,
      top: top,
      child: GestureDetector(
        onTap: onDismiss,
        child: Material(
          elevation: 8,
          borderRadius: BorderRadius.circular(25),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.copy),
                  iconSize: 22,
                  onPressed: () {
                    onCopy?.call();
                    onDismiss();
                  },
                ),
                IconButton(
                  icon: Icon(Icons.bookmark_border),
                  iconSize: 22,
                  onPressed: () {
                    onBookmark?.call();
                    onDismiss();
                  },
                ),

                IconButton(
                  icon: Icon(Icons.share),
                  iconSize: 22,
                  onPressed: () {
                    onShare?.call();
                    onDismiss();
                  },
                ),
                IconButton(
                  icon: Icon(Icons.play_arrow),
                  iconSize: 22,
                  onPressed: () {
                    onPlay?.call();
                    onDismiss();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
