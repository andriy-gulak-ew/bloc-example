import 'dart:math';

import 'package:blocweb/conversations/conversations.dart';

class ConversationsRepository {
  Future<List<Conversation>> getAll() async {
    Random randomGenerator = Random.secure();

    final numberOfConversationsGenerated = 50;
    List<Conversation> conversations = [];

    for (var i = 0; i < numberOfConversationsGenerated; i++) {
      // we distribute the type as this is just static data, for development purpose...
      String type;
      if (i % 3 == 0) {
        type = 'default';
      } else if (i % 3 == 1) {
        type = 'team_conversation';
      } else {
        type = 'group_conversation';
      }

      // The image URL is referencing assets in the project
      String imageUrl;
      if (i % 4 == 0) {
        imageUrl = 'images/conversation.png';
      }

      int unread = 0;
      if (randomGenerator.nextInt(100) > 80) {
        unread = randomGenerator.nextInt(5) + 1;
      }

      Random.secure();

      conversations.add(
        Conversation(
          id: i,
          name: 'Conversation #$i',
          type: type,
          imageUrl: imageUrl,
          unread: unread,
        ),
      );
    }

    await Future.delayed(Duration(seconds: 3), () {});

    return conversations;
  }
}
