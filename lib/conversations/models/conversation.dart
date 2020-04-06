import 'package:equatable/equatable.dart';

class Conversation extends Equatable {
  final int id;
  final String name;
  final String type;
  final String imageUrl;
  final int unread;

  Conversation({
    this.id,
    this.name,
    this.type,
    this.imageUrl,
    this.unread,
  });

  @override
  String toString() {
    return 'Conversation{id: $id, name: $name, type: $type, imageUrl: $imageUrl, unread: $unread}';
  }

  @override
  List<Object> get props => [id, name, type, unread, imageUrl];
}
