import 'package:aichatbot/firebase_options.dart';
import 'package:aichatbot/provider/chat_provider.dart';
import 'package:aichatbot/server/api_server.dart';
import 'package:aichatbot/shared/app_route.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const AiChatBot());
}

class AiChatBot extends StatelessWidget {
  const AiChatBot({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ChatProvider(OpenAIService()),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        onGenerateRoute: AppRouter.generate,
      ),
    );
  }
}
