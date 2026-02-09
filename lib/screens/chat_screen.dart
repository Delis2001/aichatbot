import 'package:aichatbot/provider/chat_provider.dart';
import 'package:aichatbot/shared/chat_bubble.dart';
import 'package:aichatbot/shared/typing_bubble.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatHomeScreen extends StatelessWidget {
  const ChatHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ChatProvider>();

    return Scaffold(
      backgroundColor: Colors.white,

      // ================= HEADER =================
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        titleSpacing: 16,
        title: Row(
          children: [
            const SizedBox(width: 40),
            Image.asset('assets/images/robot.png', width: 36),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset('assets/images/chatgpt.png', height: 16),
                const SizedBox(height: 4),
                Image.asset('assets/images/online.png', height: 14),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.volume_up_outlined),
            onPressed: () {},
          ),
          IconButton(icon: const Icon(Icons.upload_outlined), onPressed: () {}),
        ],
      ),

      // ================= BODY =================
      body: provider.messages.isEmpty
          ? const _SuggestionView()
          : const _ChatMessagesView(),

      // ================= INPUT BAR =================
      bottomNavigationBar: SafeArea(child: _InputBar(provider)),
    );
  }
}

class _SuggestionView extends StatelessWidget {
  const _SuggestionView();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _sectionTitle('explain', 'Explain'),
            const SizedBox(height: 10),

            _pill(context, 'Explain Quantum Physics', 'explain'),
            _pill(context, 'What are wormholes explain like I am 5', 'explain'),

            const SizedBox(height: 24),

            _sectionTitle('edit', 'Write & edit'),
            const SizedBox(height: 10),

            _pill(context, 'Write a tweet about global warming', 'write'),
            _pill(context, 'Write a poem about flowers', 'write'),
            _pill(context, 'Write a rap song', 'write'),

            const SizedBox(height: 24),

            _sectionTitle('translate', 'Translate'),
            const SizedBox(height: 10),

            _pill(
              context,
              'How do you say "how are you" in Korean?',
              'translate',
            ),
            _pill(context, 'What’s hello in Chinese?', 'translate'),

            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}

class _ChatMessagesView extends StatefulWidget {
  const _ChatMessagesView();

  @override
  State<_ChatMessagesView> createState() => _ChatMessagesViewState();
}

class _ChatMessagesViewState extends State<_ChatMessagesView> {
  final ScrollController _controller = ScrollController();

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_controller.hasClients) {
        _controller.animateTo(
          _controller.position.maxScrollExtent,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ChatProvider>();
    _scrollToBottom();

    return ListView.builder(
      controller: _controller,
      padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 12),
      itemCount: provider.messages.length + (provider.isLoading ? 1 : 0),
      itemBuilder: (context, index) {
        if (index < provider.messages.length) {
          return ChatBubble(message: provider.messages[index]);
        }
        return const TypingBubble();
      },
    );
  }
}

class _InputBar extends StatefulWidget {
  final ChatProvider provider;
  const _InputBar(this.provider);

  @override
  State<_InputBar> createState() => _InputBarState();
}

class _InputBarState extends State<_InputBar> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(blurRadius: 12, color: Colors.black.withOpacity(0.08)),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: 'Hello ChatGPT, how are you today?',
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send, color: Colors.blue),
            onPressed: () {
              final text = controller.text.trim();
              if (text.isEmpty) return;

              widget.provider.sendMessage(text);
              controller.clear();
            },
          ),
        ],
      ),
    );
  }
}

Widget _sectionTitle(String icon, String title) {
  return Column(
    children: [
      Image.asset('assets/images/$icon.png', width: 20),
      const SizedBox(height: 8),
      Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    ],
  );
}

Widget _pill(BuildContext context, String text, String mode) {
  final provider = context.read<ChatProvider>();

  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: GestureDetector(
      onTap: () {
        provider.setMode(mode);
        provider.sendMessage(text);
      },
      child: Container(
        width: 500,
        height: 45,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: const Color(0xFFF1F3F5),
          borderRadius: BorderRadius.circular(22),
        ),
        child: Text(text),
      ),
    ),
  );
}
