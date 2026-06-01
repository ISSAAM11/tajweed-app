import 'dart:convert';

import 'package:cg_core_defs/helpers/debugging_printer.dart';
import 'package:tajweed_ai/src/app/environment/app_environment.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../models/word_verdict_model.dart';

/// Thin wrapper around the recitation WebSocket (design.md §3, §6b).
///
/// Lifecycle: [open] → [sendConfig] → stream audio via [sendAudio] →
/// [sendStop], then [close]. Inbound server messages are exposed parsed via
/// [messages].
class RecitationSocketClient {
  WebSocketChannel? _channel;

  /// Opens the socket to the Django consumer for the current environment and
  /// waits for the handshake. Returns false if the connection cannot be
  /// established (e.g. backend down / wrong host).
  Future<bool> open() async {
    final uri = Uri.parse('${AppEnvironment.current.wsBaseUrl}/ws/recitation/');
    Debugger.cyan('[Recitation] connecting → $uri');
    final channel = WebSocketChannel.connect(uri);
    _channel = channel;
    try {
      // Fail fast if the host is unreachable instead of hanging on a long TCP
      // timeout (firewall / wrong IP / backend not bound to 0.0.0.0).
      await channel.ready.timeout(const Duration(seconds: 8));
      Debugger.green('[Recitation] WebSocket connected');
      return true;
    } catch (error) {
      Debugger.red('[Recitation] connection failed: $error');
      return false;
    }
  }

  /// First message: the expected word list the user is about to recite.
  void sendConfig(List<String> expectedWords) {
    Debugger.cyan('[Recitation] → config (${expectedWords.length} words)');
    _channel?.sink.add(
      jsonEncode({'type': 'config', 'expected_words': expectedWords}),
    );
  }

  /// Streams one raw PCM audio frame (binary).
  void sendAudio(List<int> chunk) => _channel?.sink.add(chunk);

  /// Tells the backend to finalize the session.
  void sendStop() {
    Debugger.cyan('[Recitation] → stop');
    _channel?.sink.add(jsonEncode({'type': 'stop'}));
  }

  /// Parsed inbound messages (verdict / done / error). Unparseable frames are
  /// dropped silently.
  Stream<RecitationServerMessage> get messages =>
      _channel!.stream
          .map((raw) {
            Debugger.white('[Recitation] ← $raw');
            return RecitationServerMessage.parse(raw as String);
          })
          .where((message) => message != null)
          .cast<RecitationServerMessage>();

  Future<void> close() async {
    await _channel?.sink.close();
    _channel = null;
  }
}
