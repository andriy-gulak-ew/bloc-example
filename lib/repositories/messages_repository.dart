import 'dart:math';

import 'package:blocweb/messages/messages.dart';

class MessagesRepository {
  Future<List<Message>> getByConversationId(String conversationId) async {
    print('Getting messages for conversation $conversationId');
    Random randomGenerator = Random.secure();
    List<String> sentences = [
      'How are you doing today?',
      'Cool, great stuff!',
      'What were you thinking about today? You looked to be dreaming about something.',
      'Where should we have lunch today?',
      'This is probably a silly sentence. But I need to write something that is long. This is probably long enough, soon, in a while, maybe now? Long enough!',
    ];

    List<Message> messages = [];

    for (var i = 0; i < 100; i++) {
      String imageUrl;
      int randomNumber = randomGenerator.nextInt(100);
      if (randomNumber > 90) {
        imageUrl = 'images/message-portrait.jpg';
      } else if (randomNumber > 80 && randomNumber <= 90) {
        imageUrl = 'images/message-landscape.jpg';
      }

      messages.add(
        Message(
          id: i,
          message: sentences[randomGenerator.nextInt(sentences.length)],
          sentByMe: randomGenerator.nextBool(),
          imageUrl: imageUrl,
        ),
      );
    }

    await Future.delayed(Duration(seconds: 2), () {});

    return messages;
  }
}
