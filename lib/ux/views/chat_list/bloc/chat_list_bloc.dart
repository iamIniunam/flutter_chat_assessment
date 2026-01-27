import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_assessment/platform/data_source/repositories/chat_repository.dart';
import 'package:flutter_chat_assessment/ux/views/chat_list/bloc/chat_list_event.dart';
import 'package:flutter_chat_assessment/ux/views/chat_list/bloc/chat_list_state.dart';

class ChatListBloc extends Bloc<ChatListEvent, ChatListState> {
  final ChatRepository _chatRepository;

  ChatListBloc(this._chatRepository) : super(const ChatListInitial()) {
    on<LoadChats>(_onLoadChats);
    on<RefreshChats>(_onRefreshChats);
    on<DeleteChat>(_onDeleteChat);
    on<MarkChatAsRead>(_onMarkChatAsRead);
    // on<SearchChats>(_onSearchChats);
  }

  Future<void> _onLoadChats(
      LoadChats event, Emitter<ChatListState> emit) async {
    try {
      emit(const ChatListLoading());

      await _chatRepository.seedDatabase();

      final chats = await _chatRepository.getChats();

      emit(ChatListLoaded(chats: chats));
    } catch (e) {
      emit(ChatListError('Failed to load chats: ${e.toString()}'));
    }
  }

  Future<void> _onRefreshChats(
      RefreshChats event, Emitter<ChatListState> emit) async {
    try {
      final currentState = state;

      final chats = await _chatRepository.getChats();

      if (currentState is ChatListLoaded) {
        emit(currentState.copyWith(chats: chats));
      } else {
        emit(ChatListLoaded(chats: chats));
      }
    } catch (e) {
      emit(ChatListError('Failed to refresh chats: ${e.toString()}'));
    }
  }

  Future<void> _onDeleteChat(
      DeleteChat event, Emitter<ChatListState> emit) async {
    try {
      final currentState = state;
      if (currentState is! ChatListLoaded) return;

      emit(ChatDeleteing(event.chatId));

      await _chatRepository.deleteChat(event.chatId);

      final updatedChats =
          currentState.chats.where((chat) => chat.id != event.chatId).toList();

      emit(ChatListLoaded(chats: updatedChats));
    } catch (e) {
      emit(ChatListError('Failed to delete chat: ${e.toString()}'));
    }
  }

  Future<void> _onMarkChatAsRead(
      MarkChatAsRead event, Emitter<ChatListState> emit) async {
    try {
      final currentState = state;
      if (currentState is! ChatListLoaded) return;

      await _chatRepository.markChatAsRead(event.chatId);

      final updatedChats = currentState.chats.map((chat) {
        if (chat.id == event.chatId) {
          return chat.copyWith(unreadCount: 0);
        }
        return chat;
      }).toList();

      emit(ChatListLoaded(chats: updatedChats));
    } catch (e) {
      emit(ChatListError('Failed to mark chat as read: ${e.toString()}'));
    }
  }

  // Future<void> _onSearchChats(
  //     SearchChats event, Emitter<ChatListState> emit) async {}
}
