part of 'socket_bloc.dart';

@freezed
class SocketEvent with _$SocketEvent {
  const factory SocketEvent.connect() = _SocketConnect;
  const factory SocketEvent.connecting() = _SocketConnectingEvent;
  const factory SocketEvent.onConnect() = _SocketOnConnect;
  const factory SocketEvent.onConnectError() = _SocketConnectErrorEvent;
  const factory SocketEvent.onConnectTimeout() = _SocketConnectTimeoutEvent;
  const factory SocketEvent.onError() = _SocketErrorEvent;
  const factory SocketEvent.onJoined() = _SocketJoinedEvent;
  const factory SocketEvent.disconnect() = _SocketDisconnect;
  const factory SocketEvent.changeUrl(String url) = _SocketChangeUrl;
  const factory SocketEvent.start(String url) = _SocketStart;
  const factory SocketEvent.dispose() = _SocketDispose;
  const factory SocketEvent.onDisconnect() = _SocketOnDisconnect;
}
