import 'package:flutter_chat_assessment/platform/data_source/entities/chat.dart';
import 'package:flutter_chat_assessment/platform/data_source/entities/message.dart';
import 'package:flutter_chat_assessment/platform/data_source/local/chat_database.dart';
import 'package:flutter_chat_assessment/platform/data_source/repositories/chat_repository.dart';
import 'package:flutter_chat_assessment/ux/shared/models/chat_model.dart';
import 'package:flutter_chat_assessment/ux/shared/models/message_model.dart';
import 'package:uuid/uuid.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatDatabase _chatDatabase;
  final _uuid = const Uuid();

  ChatRepositoryImpl(this._chatDatabase);

  @override
  Future<List<Chat>> getChats() async {
    final db = await _chatDatabase.database;

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
  Future<Chat?> getChatById(String chatId) async {
    final db = await _chatDatabase.database;

    final result = await db.rawQuery('''
      SELECT 
        c.id, c.user_id, c.last_message, c.last_message_time, 
        c.unread_count, c.message_status,
        u.id as user_id, u.name, u.avatar_url, u.is_online, u.last_seen
      FROM chats c
      INNER JOIN users u ON c.user_id = u.id
      WHERE c.id = ?
    ''', [chatId]);

    if (result.isEmpty) return null;

    final row = result.first;
    final userMap = {
      'id': row['user_id'],
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
  }

  @override
  Future<List<Message>> getMessages(String chatId) async {
    final db = await _chatDatabase.database;

    final result = await db.query(
      'messages',
      where: 'chat_id = ?',
      whereArgs: [chatId],
      orderBy: 'timestamp ASC',
    );

    return result.map((row) => MessageModel.fromMap(row)).toList();
  }

  @override
  Future<void> sendMessage(String chatId, String content) async {
    final db = await _chatDatabase.database;
    final now = DateTime.now();

    final message = MessageModel(
      id: _uuid.v4(),
      chatId: chatId,
      content: content,
      timestamp: now,
      isSentByMe: true,
      status: MessageStatus.sent,
    );

    await db.insert('messages', message.toMap());

    await db.update(
      'chats',
      {
        'last_message': content,
        'last_message_time': now.millisecondsSinceEpoch,
        'message_status': 'sent',
      },
      where: 'id = ?',
      whereArgs: [chatId],
    );

    Future.delayed(const Duration(seconds: 2), () async {
      await updateMessageStatus(message.id, MessageStatus.delivered);
    });
  }

  @override
  Future<void> updateMessageStatus(
      String messageId, MessageStatus status) async {
    final db = await _chatDatabase.database;

    final messages = await db.query(
      'messages',
      where: 'id = ?',
      whereArgs: [messageId],
    );

    if (messages.isEmpty) return;

    final message = messages.first;
    final chatId = message['chat_id'] as String;

    await db.update(
      'messages',
      {'status': MessageModel.statusToString(status)},
      where: 'id = ?',
      whereArgs: [messageId],
    );

    final lastMessages = await db.query(
      'messages',
      where: 'chat_id = ?',
      whereArgs: [chatId],
      orderBy: 'timestamp DESC',
      limit: 1,
    );

    if (lastMessages.isNotEmpty && lastMessages.first['id'] == messageId) {
      await db.update(
        'chats',
        {'message_status': MessageModel.statusToString(status)},
        where: 'id = ?',
        whereArgs: [chatId],
      );
    }
  }

  @override
  Future<void> markChatAsRead(String chatId) async {
    final db = await _chatDatabase.database;

    await db.update(
      'messages',
      {'status': 'read'},
      where: 'chat_id = ? AND is_sent_by_me = 0 AND status != ?',
      whereArgs: [chatId, 'read'],
    );

    await db.update(
      'chats',
      {'unread_count': 0},
      where: 'id = ?',
      whereArgs: [chatId],
    );
  }

  @override
  Future<void> deleteChat(String chatId) async {
    final db = await _chatDatabase.database;

    await db.delete(
      'messages',
      where: 'chat_id = ?',
      whereArgs: [chatId],
    );

    await db.delete(
      'chats',
      where: 'id = ?',
      whereArgs: [chatId],
    );
  }

  @override
  Future<void> seedDatabase() async {
    await _chatDatabase.seedSampleData();
  }
}
