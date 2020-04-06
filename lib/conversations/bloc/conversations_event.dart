part of 'conversations_bloc.dart';

@immutable
abstract class ConversationsEvent extends Equatable {
  const ConversationsEvent();
}

class LoadConversations extends ConversationsEvent {
  @override
  List<Object> get props => [];
}
