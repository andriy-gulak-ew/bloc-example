part of 'messages_bloc.dart';

@immutable
abstract class MessagesState extends Equatable {
  const MessagesState();
}

class MessagesLoading extends MessagesState {
  @override
  List<Object> get props => [];
}

class MessagesLoaded extends MessagesState {
  final List<Message> messages;

  const MessagesLoaded(this.messages);

  @override
  List<Object> get props => [messages];
}

class MessagesError extends MessagesState {
  final String error;

  const MessagesError(this.error);

  @override
  List<Object> get props => [error];
}
