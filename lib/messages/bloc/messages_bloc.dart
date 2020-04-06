import 'package:blocweb/messages/models/message.dart';
import 'package:blocweb/repositories/messages_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'messages_event.dart';

part 'messages_state.dart';

class MessagesBloc extends Bloc<MessagesEvent, MessagesState> {
  final MessagesRepository messagesRepository;

  MessagesBloc({@required this.messagesRepository})
      : assert(messagesRepository != null);

  @override
  MessagesState get initialState => MessagesLoading();

  @override
  Stream<MessagesState> mapEventToState(MessagesEvent event) async* {
    if (event is LoadMessages) {
      yield* _mapLoadMessagesToState(event);
    } else if (event is AddMessage) {
      yield* _mapAddMessageToState(event);
    }
  }

  Stream<MessagesState> _mapLoadMessagesToState(LoadMessages event) async* {
    yield MessagesLoading();
    try {
      final messagesList = await messagesRepository.getByConversationId(event.conversationId.toString());
      yield MessagesLoaded(messagesList);
    } catch (error) {
      yield MessagesError(error);
    }
  }

  Stream<MessagesState> _mapAddMessageToState(AddMessage event) async* {
    final currentState = state;
    if (currentState is MessagesLoaded) {
      try {
        yield MessagesLoaded(
          List.from(currentState.messages)..insert(0, event.message),
        );
      } catch (error) {
        yield MessagesError(error);
      }
    }
  }
}
