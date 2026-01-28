import 'package:equatable/equatable.dart';
import 'package:flutter_chat_assessment/platform/data_source/entities/chat.dart';
import 'package:flutter_chat_assessment/ux/shared/models/ui_models.dart';

abstract class ChatFeedState extends Equatable {
  const ChatFeedState();

  @override
  List<Object?> get props => [];
}

class ChatFeedInitial extends ChatFeedState {
  const ChatFeedInitial();
}

class ChatFeedLoading extends ChatFeedState {
  const ChatFeedLoading();
}

class ChatFeedLoaded extends ChatFeedState {
  final List<Chat> chats;
  final List<StoryItem> stories;

  const ChatFeedLoaded({required this.chats, required this.stories});

  List<Chat> get displayChats => chats;
  List<StoryItem> get displayStories => stories;

  @override
  List<Object?> get props => [chats, stories];

  ChatFeedLoaded copyWith({List<Chat>? chats, List<StoryItem>? stories}) {
    return ChatFeedLoaded(
      chats: chats ?? this.chats,
      stories: stories ?? this.stories,
    );
  }
}

class ChatFeedError extends ChatFeedState {
  final String message;

  const ChatFeedError(this.message);

  @override
  List<Object?> get props => [message];
}
