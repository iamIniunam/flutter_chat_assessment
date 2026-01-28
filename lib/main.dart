import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_assessment/platform/data_source/local/chat_feed_database.dart';
import 'package:flutter_chat_assessment/platform/data_source/repositories/chat_feed_repository_impl.dart';
import 'package:flutter_chat_assessment/ux/navigation/navigation_host_page.dart';
import 'package:flutter_chat_assessment/ux/resources/app_theme.dart';
import 'package:flutter_chat_assessment/ux/views/chat_feed/bloc/chat_feed_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final database = ChatFeedDatabase.instance;
    final repository = ChatFeedRepositoryImpl(database);

    return MultiBlocProvider(
      providers: [
        BlocProvider<ChatFeedBloc>(
          create: (context) => ChatFeedBloc(repository),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Chat Assessment',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: const NavigationHostPage(),
      ),
    );
  }
}
