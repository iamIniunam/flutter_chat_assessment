import 'package:flutter_chat_assessment/platform/data_source/entities/chat.dart';
import 'package:flutter_chat_assessment/platform/data_source/local/chat_feed_database.dart';
import 'package:flutter_chat_assessment/platform/data_source/repositories/chat_feed_repository.dart';
import 'package:flutter_chat_assessment/ux/shared/models/chat_model.dart';
import 'package:flutter_chat_assessment/ux/shared/models/ui_models.dart';

class ChatFeedRepositoryImpl implements ChatFeedRepository {
  final ChatFeedDatabase _chatFeedDatabase;

  ChatFeedRepositoryImpl(this._chatFeedDatabase);

  @override
  Future<List<Chat>> getChats() async {
    final db = await _chatFeedDatabase.database;

    final result = await db.rawQuery('''
      SELECT 
        c.id, c.user_id, c.last_message, c.last_message_time, 
        c.unread_count, c.message_status,
        u.id as user_id, u.name, u.avatar_url, u.is_online, u.last_seen
      FROM chats c
      INNER JOIN users u ON c.user_id = u.id
      ORDER BY c.last_message_time DESC
    ''');

    return result.map((row) {
      final userMap = {
        'id': row['id'],
        'name': row['name'],
        'avatar_url': row['avatar_url'],
        'is_online': row['is_online'],
        'last_seen': row['last_seen'],
      };

      final chatMap = {
        'id': row['id'],
        'user_id': row['user_id'],
        'last_message': row['last_message'],
        'last_message_time': row['last_message_time'],
        'unread_count': row['unread_count'],
        'message_status': row['message_status'],
      };

      return ChatModel.fromMap(chatMap, userMap);
    }).toList();
  }

  @override
  Future<List<StoryItem>> getStories() async {
    final db = await _chatFeedDatabase.database;

    final result = await db.query(
      'users',
      where: "id IN (?, ?, ?, ?)",
      whereArgs: ['user_john', 'user_sheril', 'user_mark', 'user_aler'],
    );

    return result.map((row) {
      return StoryItem(
        label: row['name'] as String,
        avatarUrl: row['avatar_url'] as String,
      );
    }).toList();
  }

  @override
  Future<void> seedDatabase() async {
    await _chatFeedDatabase.seedSampleData();
  }
}
