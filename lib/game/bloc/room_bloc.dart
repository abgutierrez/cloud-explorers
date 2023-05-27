import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_explorers/socket/bloc/socket_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../models/room.dart';

part 'room_event.dart';
part 'room_state.dart';
part 'room_bloc.freezed.dart';

class RoomBloc extends Bloc<RoomEvent, RoomState> {
  RoomBloc(SocketBloc socketBloc)
      : socketBloc = socketBloc,
        super(_Initial()) {
    on<_GetDefaultRoom>(onDefaultRoomRequested);
  }
  SocketBloc socketBloc;
  FutureOr<void> onDefaultRoomRequested(
      RoomEvent event, Emitter<RoomState> emit) {
    emit(RoomState.loading());
    socketBloc.add(const SocketEvent.start('http://localhost:3000'));
    socketBloc.add(const SocketEvent.connect());
    emit(RoomState.loaded(Rooms.azure));
  }

  bool isLoading() {
    return state is _Loading;
  }
}
