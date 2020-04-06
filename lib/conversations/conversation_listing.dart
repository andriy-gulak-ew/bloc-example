import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:blocweb/conversations/conversations.dart';
import 'package:blocweb/messages/messages.dart';
import 'package:blocweb/routes.dart';

class ConversationListing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConversationsBloc, ConversationsState>(
      builder: (context, state) {
        if (state is ConversationsLoading) {
          return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (state is ConversationsLoaded) {
          return ListView.builder(
            itemCount: state.conversations.length,
            itemBuilder: (context, index) {
              return ConversationItem(conversation: state.conversations[index]);
            },
          );
        }
        return Text('Something went wrong!');
      },
    );
  }
}

class ConversationItem extends StatelessWidget {
  final Conversation conversation;

  ConversationItem({@required this.conversation, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var unread = conversation.unread;
    return ListTile(
      dense: unread == 0,
      selected: unread > 0,
      leading: _createLeadingWidgetByType(conversation),
      title: Text(conversation.name ?? ''),
      trailing: unread > 0 ? CircleAvatar(child: Text(unread.toString()), maxRadius: 12) : null,
      onTap: () {
        Navigator.of(context).pushNamed(conversationRoute, arguments: conversation);
        BlocProvider.of<MessagesBloc>(context).add(LoadMessages(conversation.id));
      },
    );
  }

  Widget _createLeadingWidgetByType(Conversation conversation) {
    if (conversation.imageUrl != null) {
      return CircleAvatar(
        backgroundImage: AssetImage(conversation.imageUrl),
      );
    } else if (conversation.type == 'default') {
      return CircleAvatar(
        child: Text(
          conversation.name != null ? conversation.name[0] : '',
          style: TextStyle(fontSize: 32),
        ),
      );
    } else if (conversation.type == 'group_conversation') {
      return CircleAvatar(child: Icon(Icons.inbox));
    } else {
      return CircleAvatar(child: Icon(Icons.image));
    }
  }
}
