part of 'room_bloc.dart';

//I want to create an enum with the rooms in the game
enum Rooms { azure, ibmCloud, aws }

@freezed
class RoomEvent with _$RoomEvent {
  const factory RoomEvent.started() = _Started;
  const factory RoomEvent.changeRoom(Rooms room) = _ChangeRoom;
  const factory RoomEvent.getDefaultRoom() = _GetDefaultRoom;
}
