import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:blocweb/application_utils.dart';
import 'package:blocweb/common/image_view.dart';
import 'package:blocweb/conversations/models/conversation.dart';
import 'package:blocweb/messages/messages.dart';

class MessagesView extends StatefulWidget {
  final Conversation conversation;

  MessagesView(this.conversation);

  @override
  _MessagesViewState createState() => _MessagesViewState();
}

class _MessagesViewState extends State<MessagesView> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _editingController = TextEditingController();

  bool _isSendButtonEnabled = false;
  MessagesBloc _messagesBloc;

  @override
  void initState() {
    super.initState();
    _messagesBloc = BlocProvider.of<MessagesBloc>(context);
    _editingController.addListener(() {
      setState(() {
        _isSendButtonEnabled =
            _editingController.text != null && _editingController.text.isNotEmpty;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: isTablet(context) ? null : BackButton(color: Colors.white),
        title: Text(widget.conversation.name),
      ),
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Expanded(
                child: BlocBuilder<MessagesBloc, MessagesState>(
                  builder: (context, state) {
                    if (state is MessagesLoading) {
                      return Container(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    if (state is MessagesLoaded) {
                      return ListView.builder(
                        reverse: true,
                        controller: _scrollController,
                        itemCount: state.messages.length,
                        itemBuilder: (context, index) {
                          return MessageItem(state.messages[index]);
                        },
                      );
                    }
                    return Text('Something went wrong!');
                  },
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: _editingController,
                        decoration: InputDecoration(
                          hintText: 'Write your message here...',
                          hintStyle: TextStyle(color: Colors.grey),
                          contentPadding: const EdgeInsets.all(20.0),
                        ),
                      ),
                    ),
                  ),
                  Material(
                    child: IconButton(
                      icon: Icon(Icons.send),
                      onPressed: _isSendButtonEnabled
                          ? () {
                              _messagesBloc.add(
                                AddMessage(
                                  Message(
                                      id: 0,
                                      message: _editingController.text,
                                      sentByMe: true,
                                      imageUrl: null),
                                ),
                              );
                              _scrollController.animateTo(0,
                                  duration: Duration(milliseconds: 300), curve: Curves.linear);
                              _editingController.clear();
                            }
                          : null,
                      color: Theme.of(context).primaryColor,
                    ),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MessageItem extends StatelessWidget {
  final Message message;

  const MessageItem(this.message);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: message.sentByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: <Widget>[
        message.imageUrl != null
            ? _imageView(context, message.imageUrl)
            : Container(
                width: 240,
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: EdgeInsets.all(8),
                child: Text(
                  message.message,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              )
      ],
    );
  }

  Widget _imageView(BuildContext context, String imageUrl) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ImageView(imageUrl: imageUrl),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        child: Image.asset(
          imageUrl,
          width: 100,
          height: 100,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
