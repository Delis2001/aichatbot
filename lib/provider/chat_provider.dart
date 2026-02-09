import 'package:aichatbot/model/chat_model.dart';
import 'package:aichatbot/server/api_server.dart';
import 'package:flutter/foundation.dart';

class ChatProvider extends ChangeNotifier {
  final OpenAIService openAI;

  ChatProvider(this.openAI);

  final List<ChatMessage> messages = [];
  String mode = 'chat';
  bool isLoading = false;

  void setMode(String newMode) {
    mode = newMode;
    notifyListeners();
  }

  Future<void> sendMessage(String text) async {
    messages.add(ChatMessage(text: text, sender: Sender.user));
    isLoading = true;
    notifyListeners();

    try {
      final reply = await openAI.sendMessage(
        message: text,
        mode: mode,
      );

      messages.add(ChatMessage(text: reply, sender: Sender.bot));
    } catch (e) {
      messages.add(
        ChatMessage(
          text: '⚠️ Something went wrong. Try again.',
          sender: Sender.bot,
        ),
      );
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
