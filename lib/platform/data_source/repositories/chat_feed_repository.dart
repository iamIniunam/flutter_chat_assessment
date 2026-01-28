import 'package:flutter_chat_assessment/platform/data_source/entities/chat.dart';
import 'package:flutter_chat_assessment/ux/shared/models/ui_models.dart';

abstract class ChatFeedRepository {
  Future<List<Chat>> getChats();

  Future<List<StoryItem>> getStories();

  Future<void> seedDatabase();
}
