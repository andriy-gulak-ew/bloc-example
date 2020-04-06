import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:blocweb/conversations/models/conversation.dart';
import 'package:blocweb/repositories/conversations_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'conversations_event.dart';

part 'conversations_state.dart';

class ConversationsBloc extends Bloc<ConversationsEvent, ConversationsState> {
  final ConversationsRepository conversationsRepository;

  ConversationsBloc({@required this.conversationsRepository})
      : assert(conversationsRepository != null);

  @override
  ConversationsState get initialState => ConversationsLoading();

  @override
  Stream<ConversationsState> mapEventToState(ConversationsEvent event) async* {
    if (event is LoadConversations) {
      yield* _mapLoadConversationsToState();
    }
  }

  Stream<ConversationsState> _mapLoadConversationsToState() async* {
    yield ConversationsLoading();
    try {
      final conversationsList = await conversationsRepository.getAll();
      print('conversationsList $conversationsList');
      yield ConversationsLoaded(conversationsList);
    } catch (error) {
      yield ConversationsError(error);
    }
  }
}
