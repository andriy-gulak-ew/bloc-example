part of 'messages_bloc.dart';

@immutable
abstract class MessagesEvent extends Equatable {
  const MessagesEvent();
}

class AddMessage extends MessagesEvent {
  final Message message;

  const AddMessage(this.message);

  @override
  List<Object> get props => [message];
}

class LoadMessages extends MessagesEvent {
  final int conversationId;

  LoadMessages(this.conversationId);

  @override
  List<Object> get props => [conversationId];
}
