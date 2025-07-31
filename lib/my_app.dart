import 'package:chatting_app_flutter_firebase/ui/screens/chat_screen.dart';
import 'package:chatting_app_flutter_firebase/ui/screens/home_screen.dart';
import 'package:chatting_app_flutter_firebase/ui/screens/onbording_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChattingApp extends StatelessWidget {
  const ChattingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      routes: {
        OnboardingScreen.name:(context)=>OnboardingScreen(),
        HomeScreen.name:(context)=>HomeScreen(),
        ChatScreen.name:(context)=>ChatScreen()
      },
    );
  }
}
