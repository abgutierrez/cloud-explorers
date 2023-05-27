import 'package:cloud_explorers/models/room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RoomRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Room>> getRoomsById(String id) async {
    try {
      final List<Room> rooms = [];
      final QuerySnapshot snapshot =
          await _firestore.collection('rooms').where('id', isEqualTo: id).get();

      for (final doc in snapshot.docs) {
        final room = Room.fromSnapshot(doc);
        rooms.add(room);
      }

      return rooms;
    } catch (e) {
      // Manejo de errores
      print('Error al obtener usuarios por correo electrónico: $e');
      return [];
    }
  }
}
