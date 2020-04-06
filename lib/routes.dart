import 'package:flutter/material.dart';
import 'package:blocweb/application_utils.dart';
import 'package:blocweb/conversations/models/conversation.dart';
import 'package:blocweb/messages/messages_view.dart';
import 'package:blocweb/screens/unknown.dart';

const String conversationRoute = 'conversation';

Route handleOnRouteGeneration(settings) {
  switch (settings.name) {
    case conversationRoute:
      var conversation = settings.arguments as Conversation;
      return DetailRoute(
          builder: (context) => MessagesView(conversation),
          settings: RouteSettings(name: "$conversationRoute/${conversation.id}"));
    default:
      return MaterialPageRoute(builder: (_) => UnknownScreen());
  }
}

class DetailRoute<T> extends TransitionRoute<T> with LocalHistoryRoute<T> {
  DetailRoute({@required this.builder, RouteSettings settings}) : super(settings: settings);

  final WidgetBuilder builder;

  @override
  Iterable<OverlayEntry> createOverlayEntries() {
    return [
      OverlayEntry(builder: (context) {
        return Positioned(
            left: isTablet(context) ? kTabletMasterContainerWidth : 0,
            top: 0,
            child: SizedBox(
                height: isTablet(context) ? MediaQuery.of(context).size.height - kMinInteractiveDimension : MediaQuery.of(context).size.height,
                width: isTablet(context)
                    ? MediaQuery.of(context).size.width - kTabletMasterContainerWidth
                    : MediaQuery.of(context).size.width,
                child: builder(context)));
      })
    ];
  }

  @override
  void install(OverlayEntry insertionPoint) {
    super.install(insertionPoint);
  }

  @override
  bool didPop(T result) {
    final bool returnValue = super.didPop(result);
    assert(returnValue);
    if (finishedWhenPopped) {
      navigator.finalizeRoute(this);
    }
    return returnValue;
  }

  @override
  bool get opaque => false;

  @override
  Duration get transitionDuration => Duration(milliseconds: 250);
}
