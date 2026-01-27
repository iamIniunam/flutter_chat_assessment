import 'package:flutter_chat_assessment/platform/data_source/entities/chat.dart';
import 'package:flutter_chat_assessment/ux/shared/models/message_model.dart';
import 'package:flutter_chat_assessment/ux/shared/models/user_model.dart';

class ChatModel extends Chat {
  const ChatModel({
    required super.id,
    required super.user,
    required super.lastMessage,
    required super.lastMessageTime,
    super.unreadCount,
    super.messageStatus,
  });

  factory ChatModel.fromEntity(Chat chat) {
    return ChatModel(
      id: chat.id,
      user: chat.user,
      lastMessage: chat.lastMessage,
      lastMessageTime: chat.lastMessageTime,
      unreadCount: chat.unreadCount,
      messageStatus: chat.messageStatus,
    );
  }

  factory ChatModel.fromMap(
    Map<String, dynamic> chatMap,
    Map<String, dynamic> userMap,
  ) {
    return ChatModel(
      id: chatMap['id'] ?? '',
      user: UserModel.fromMap(userMap),
      lastMessage: chatMap['last_message'] ?? '',
      lastMessageTime: DateTime.fromMillisecondsSinceEpoch(
        chatMap['last_message_time'] ?? 0,
      ),
      unreadCount: chatMap['unread_count'] ?? 0,
      messageStatus:
          MessageModel.stringToStatus(chatMap['message_status'] ?? ''),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': user.id,
      'last_message': lastMessage,
      'last_message_time': lastMessageTime.millisecondsSinceEpoch,
      'unread_count': unreadCount,
      'message_status': MessageModel.statusToString(messageStatus),
    };
  }
}
