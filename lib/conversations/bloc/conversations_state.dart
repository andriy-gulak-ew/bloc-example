part of 'conversations_bloc.dart';

@immutable
abstract class ConversationsState extends Equatable {
  const ConversationsState();
}

class ConversationsLoading extends ConversationsState {
  @override
  List<Object> get props => [];
}

class ConversationsLoaded extends ConversationsState {
  final List<Conversation> conversations;

  const ConversationsLoaded(this.conversations);

  @override
  List<Object> get props => [conversations];
}

class ConversationsError extends ConversationsState {
  final String error;

  const ConversationsError(this.error);

  @override
  List<Object> get props => [error];
}
