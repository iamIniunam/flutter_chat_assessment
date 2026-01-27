import 'package:flutter_chat_assessment/platform/data_source/entities/message.dart';

class MessageModel extends Message {
  const MessageModel({
    required super.id,
    required super.chatId,
    required super.content,
    required super.timestamp,
    required super.isSentByMe,
    super.status,
  });

  factory MessageModel.fromEntity(Message message) {
    return MessageModel(
      id: message.id,
      chatId: message.chatId,
      content: message.content,
      timestamp: message.timestamp,
      isSentByMe: message.isSentByMe,
      status: message.status,
    );
  }

  factory MessageModel.fromMap(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'] as String,
      chatId: json['chatId'] as String,
      content: json['content'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      isSentByMe: (json['isSentByMe'] as int) == 1,
      status: MessageStatus.values[json['status'] as int],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'chatId': chatId,
      'content': content,
      'timestamp': timestamp.toIso8601String(),
      'isSentByMe': isSentByMe ? 1 : 0,
      'status': status.index,
    };
  }

  static String statusToString(MessageStatus status) {
    switch (status) {
      case MessageStatus.sent:
        return 'sent';
      case MessageStatus.delivered:
        return 'delivered';
      case MessageStatus.read:
        return 'read';
    }
  }

  static MessageStatus stringToStatus(String status) {
    switch (status.toLowerCase()) {
      case 'sent':
        return MessageStatus.sent;
      case 'delivered':
        return MessageStatus.delivered;
      case 'read':
        return MessageStatus.read;
      default:
        return MessageStatus.sent;
    }
  }
}
