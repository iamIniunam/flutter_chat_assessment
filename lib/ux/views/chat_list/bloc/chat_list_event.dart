import 'package:equatable/equatable.dart';

class ChatListEvent extends Equatable {
  const ChatListEvent();

  @override
  List<Object?> get props => [];
}

class LoadChats extends ChatListEvent {
  const LoadChats();
}

class RefreshChats extends ChatListEvent {
  const RefreshChats();
}

class DeleteChat extends ChatListEvent {
  final String chatId;

  const DeleteChat(this.chatId);

  @override
  List<Object?> get props => [chatId];
}

class MarkChatAsRead extends ChatListEvent {
  final String chatId;

  const MarkChatAsRead(this.chatId);

  @override
  List<Object?> get props => [chatId];
}

class SearchChats extends ChatListEvent {
  final String query;

  const SearchChats(this.query);

  @override
  List<Object?> get props => [query];
}
