import 'package:equatable/equatable.dart';

class ChatFeedEvent extends Equatable {
  const ChatFeedEvent();

  @override
  List<Object?> get props => [];
}

class LoadChatFeed extends ChatFeedEvent {
  const LoadChatFeed();
}

class RefreshChats extends ChatFeedEvent {
  const RefreshChats();
}
