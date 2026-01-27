import 'package:flutter/material.dart';
import 'package:flutter_chat_assessment/ux/resources/app_theme.dart';
import 'package:flutter_chat_assessment/ux/views/chat_list/chat_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Chat Assestment',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const ChatListScreen(),
    );
  }
}
