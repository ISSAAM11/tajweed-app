import 'package:flutter/material.dart' show TextEditingController, FocusNode;

class InputControl {
  final TextEditingController controller;
  final FocusNode node;

  const InputControl({
    required this.controller,
    required this.node,
  });

  factory InputControl.single() => InputControl(
        controller: TextEditingController(),
        node: FocusNode(),
      );

  static List<InputControl> generate(int count) => List<InputControl>.generate(
        count,
        (_) => InputControl(controller: TextEditingController(), node: FocusNode()),
      );

  void dispose() {
    controller.dispose();
    node.dispose();
  }
}

extension InputControlsListDisposer on List<InputControl> {
  void disposeAll() => forEach((element) {
        element.controller.dispose();
        element.node.dispose();
      });
  void clearAllTECs() => forEach((element) => element.controller.clear());
  void unfocusAllFocusNodes() => forEach((element) => element.node.unfocus());
}
