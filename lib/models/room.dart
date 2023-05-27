import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

@JsonSerializable()
class Room {
  final String id;
  final String url;

  Room({required this.id, required this.url});

  factory Room.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return Room(
      id: data['id'] ?? '',
      url: data['url'],
    );
  }
}
