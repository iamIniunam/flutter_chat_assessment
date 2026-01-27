import 'package:flutter_chat_assessment/platform/data_source/entities/chat.dart';
import 'package:flutter_chat_assessment/platform/data_source/entities/message.dart';

abstract class ChatRepository {
  Future<List<Chat>> getChats();

  Future<Chat?> getChatById(String chatId);

  Future<List<Message>> getMessages(String chatId);

  Future<void> sendMessage(String chatId, String content);

  Future<void> updateMessageStatus(String messageId, MessageStatus status);

  Future<void> markChatAsRead(String chatId);

  Future<void> deleteChat(String chatId);

  Future<void> seedDatabase();
}
