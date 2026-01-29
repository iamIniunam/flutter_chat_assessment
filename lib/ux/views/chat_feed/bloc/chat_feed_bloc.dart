import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_assessment/platform/data_source/repositories/chat_feed_repository.dart';
import 'package:flutter_chat_assessment/ux/views/chat_feed/bloc/chat_feed_event.dart';
import 'package:flutter_chat_assessment/ux/views/chat_feed/bloc/chat_feed_state.dart';

class ChatFeedBloc extends Bloc<ChatFeedEvent, ChatFeedState> {
  final ChatFeedRepository _repository;

  ChatFeedBloc(this._repository) : super(const ChatFeedInitial()) {
    on<LoadChatFeed>(_onLoadChatFeed);
    on<RefreshChatFeed>(_onRefreshChatFeed);
  }

  Future<void> _onLoadChatFeed(
      LoadChatFeed event, Emitter<ChatFeedState> emit) async {
    try {
      emit(const ChatFeedLoading());

      await _repository.seedDatabase();

      final chats = await _repository.getChats();
      final stories = await _repository.getStories();

      emit(ChatFeedLoaded(chats: chats, stories: stories));
    } catch (e) {
      emit(ChatFeedError('Failed to load chats and stories: ${e.toString()}'));
    }
  }

  Future<void> _onRefreshChatFeed(
      RefreshChatFeed event, Emitter<ChatFeedState> emit) async {
    try {
      final currentState = state;
      final chats = await _repository.getChats();
      final stories = await _repository.getStories();
      if (currentState is ChatFeedLoaded) {
        emit(currentState.copyWith(chats: chats, stories: stories));
      } else {
        emit(ChatFeedLoaded(chats: chats, stories: stories));
      }
    } catch (e) {
      emit(ChatFeedError('Failed to refresh chats: ${e.toString()}'));
    }
  }
}
