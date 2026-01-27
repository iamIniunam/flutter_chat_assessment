import 'package:equatable/equatable.dart';
import 'package:flutter_chat_assessment/platform/data_source/entities/chat.dart';

abstract class ChatListState extends Equatable {
  const ChatListState();

  @override
  List<Object?> get props => [];
}

class ChatListInitial extends ChatListState {
  const ChatListInitial();
}

class ChatListLoading extends ChatListState {
  const ChatListLoading();
}

class ChatListLoaded extends ChatListState {
  final List<Chat> chats;
  final List<Chat> filteredChats;
  final String searchQuery;

  const ChatListLoaded({
    required this.chats,
    List<Chat>? filteredChats,
    this.searchQuery = '',
  }) : filteredChats = filteredChats ?? chats;

  List<Chat> get displayChats => searchQuery.isEmpty ? chats : filteredChats;

  @override
  List<Object?> get props => [chats, filteredChats, searchQuery];

  ChatListLoaded copyWith({
    List<Chat>? chats,
    List<Chat>? filteredChats,
    String? searchQuery,
  }) {
    return ChatListLoaded(
      chats: chats ?? this.chats,
      filteredChats: filteredChats ?? this.filteredChats,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}

class ChatListError extends ChatListState {
  final String message;

  const ChatListError(this.message);

  @override
  List<Object?> get props => [message];
}

class ChatDeleteing extends ChatListState {
  final String chatId;

  const ChatDeleteing(this.chatId);

  @override
  List<Object?> get props => [chatId];
}
