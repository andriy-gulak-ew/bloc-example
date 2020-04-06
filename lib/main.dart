import 'package:blocweb/conversations/bloc/conversations_bloc.dart';
import 'package:blocweb/messages/bloc/messages_bloc.dart';
import 'package:blocweb/repositories/conversations_repository.dart';
import 'package:blocweb/repositories/messages_repository.dart';
import 'package:blocweb/routes.dart';
import 'package:blocweb/screens/home.dart';
import 'package:blocweb/simple_bloc_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  final ConversationsRepository conversationsRepository =
      ConversationsRepository();
  final MessagesRepository messagesRepository = MessagesRepository();

  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(App(conversationsRepository: conversationsRepository, messagesRepository: messagesRepository));
}

class App extends StatelessWidget {
  final ConversationsRepository conversationsRepository;
  final MessagesRepository messagesRepository;

  const App({
    Key key,
    @required this.conversationsRepository,
    @required this.messagesRepository,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ConversationsBloc>(
          create: (context) => ConversationsBloc(
              conversationsRepository: conversationsRepository)
            ..add(LoadConversations()),
        ),
        BlocProvider<MessagesBloc>(
          create: (context) =>
              MessagesBloc(messagesRepository: messagesRepository),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: HomeScreen(),
        onGenerateRoute: handleOnRouteGeneration,
      ),
    );
  }
}
