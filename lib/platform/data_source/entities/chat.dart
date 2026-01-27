import 'package:equatable/equatable.dart';
import 'user.dart';
import 'message.dart';

class Chat extends Equatable {
  final String id;
  final User user;
  final String lastMessage;
  final DateTime lastMessageTime;
  final int unreadCount;
  final MessageStatus messageStatus;

  const Chat({
    required this.id,
    required this.user,
    required this.lastMessage,
    required this.lastMessageTime,
    this.unreadCount = 0,
    this.messageStatus = MessageStatus.delivered,
  });

  @override
  List<Object?> get props => [
        id,
        user,
        lastMessage,
        lastMessageTime,
        unreadCount,
        messageStatus,
      ];

  Chat copyWith({
    String? id,
    User? user,
    String? lastMessage,
    DateTime? lastMessageTime,
    int? unreadCount,
    MessageStatus? messageStatus,
  }) {
    return Chat(
      id: id ?? this.id,
      user: user ?? this.user,
      lastMessage: lastMessage ?? this.lastMessage,
      lastMessageTime: lastMessageTime ?? this.lastMessageTime,
      unreadCount: unreadCount ?? this.unreadCount,
      messageStatus: messageStatus ?? this.messageStatus,
    );
  }
}
