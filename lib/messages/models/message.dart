class Message {
  int id;
  String message;
  bool sentByMe;
  String imageUrl;

  Message({this.id, this.message, this.sentByMe, this.imageUrl});

  @override
  String toString() {
    return 'Message{id: $id, message: $message, sentByMe: $sentByMe, imageUrl: $imageUrl}';
  }
}

