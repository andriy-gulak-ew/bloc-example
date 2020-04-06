#  Flutter BloC + Web

A simple Flutter Example Project created with help of BloC pattern. This app supports Flutter Web and optimized for large screen sizes.


## Getting Started

In order to run this project in browser, please enable Flutter Web support:

1. Follow the link below to setup Flutter Web:

https://flutter.dev/docs/get-started/web#set-up

2. To serve your app from localhost in Chrome, enter the following in terminal:

`flutter run -d chrome`


## App implementation

The idea behind this project is to create simple app with BloC state management and Flutter Web support.
There are only two views with master-details layout.

Conversation listing view
-------------------------

The main view is a conversation/chat listing, meaning listing a set of conversations.

The Conversation listing view is a list based on material ListTile.

The data model has the following:
- Conversation.id - just the id (integer), to be used to reference the conversation in the listing page.
- Conversation.type - the conversation type:
  - default: show the first letter of the conversation.name as tile head.
  - group_conversation: show some icon as the tile head.
  - team_conversation: show some other icon than the group_conversation as the tile head.
- Conversation.imageurl - if not null, show the image insteaad of the conversation.type description above.
- Conversation.name - string that is the name of the conversation.
- Conversation.unread - number of unread messages. If > 0 the count should be shown somehow, and the list tile should be different somehow to stand out from the other conversations.

Clicking on one of the conversations will load open new page / route referencing the conversation.id for the item
clicked on.


Messages view
--------------------------

This is the view that one is routed to when clicking on one of the conversations in the Conversation listing view.

There should not be any bottom navigation bar nor FAB.

The top bar should have a back button to the left, and show the conversation details similar as in the
conversation listing view.

In the bottom there should be a text field together with a send button. 
When adding text, the send button gets enabled, and when clicking on it append it to the messages (no need to persist the message).

There is a Future that contains a list of Message objects. 
The first item in the returned list is the last message sent.

- Message.id (not used)
- Message.message (the actual text)
- Message.sentByMe (boolean to indicate if the app user was the sender of the message or not). If false the
  message should be on the left sidee, if true then it should be on the right side.
- Message.imageUrl asset url to an image. The image should be shown as a cropped square. Use some resonable size. When clicking on the image full image should be shown.

**Additional requirements:**
- The app should be implemented with help of Bloc design pattern
- The app should have different view on large device, where the conversation listing is on the left, and conversation is on the right. Similar to how WhatsApp Desktop does.
