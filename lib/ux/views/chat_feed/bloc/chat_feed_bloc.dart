import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_assessment/platform/data_source/repositories/chat_feed_repository.dart';
import 'package:flutter_chat_assessment/ux/views/chat_feed/bloc/chat_feed_event.dart';
import 'package:flutter_chat_assessment/ux/views/chat_feed/bloc/chat_feed_state.dart';

class ChatFeedBloc extends Bloc<ChatFeedEvent, ChatFeedState> {
  final ChatFeedRepository _repository;

  ChatFeedBloc(this._repository) : super(const ChatFeedInitial()) {
    on<LoadChatFeed>(_onLoadData);
    on<RefreshChats>(_onRefreshChats);
  }

  Future<void> _onLoadData(
      LoadChatFeed event, Emitter<ChatFeedState> emit) async {
    try {
      emit(const ChatFeedLoading());
      final chats = await _repository.getChats();
      final stories = await _repository.getStories();
      emit(ChatFeedLoaded(chats: chats, stories: stories));
    } catch (e) {
      debugPrint(e.toString());
      emit(ChatFeedError('Failed to load chats and stories: ${e.toString()}'));
    }
  }

  Future<void> _onRefreshChats(
      RefreshChats event, Emitter<ChatFeedState> emit) async {
    try {
      final currentState = state;
      final chats = await _repository.getChats();
      if (currentState is ChatFeedLoaded) {
        emit(currentState.copyWith(chats: chats));
      } else {
        emit(ChatFeedLoaded(chats: chats, stories: const []));
      }
    } catch (e) {
      emit(ChatFeedError('Failed to refresh chats: ${e.toString()}'));
    }
  }
}
