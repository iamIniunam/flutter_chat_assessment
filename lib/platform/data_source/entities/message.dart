import 'package:equatable/equatable.dart';

enum MessageStatus { sent, delivered, read }

class Message extends Equatable {
  final String id;
  final String chatId;
  final String content;
  final DateTime timestamp;
  final bool isSentByMe;
  final MessageStatus status;

  const Message({
    required this.id,
    required this.chatId,
    required this.content,
    required this.timestamp,
    required this.isSentByMe,
    this.status = MessageStatus.sent,
  });

  @override
  List<Object?> get props =>
      [id, chatId, content, timestamp, isSentByMe, status];

  Message copyWith({
    String? id,
    String? chatId,
    String? content,
    DateTime? timestamp,
    bool? isSentByMe,
    MessageStatus? status,
  }) {
    return Message(
      id: id ?? this.id,
      chatId: chatId ?? this.chatId,
      content: content ?? this.content,
      timestamp: timestamp ?? this.timestamp,
      isSentByMe: isSentByMe ?? this.isSentByMe,
      status: status ?? this.status,
    );
  }
}
