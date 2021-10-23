import 'dart:collection';

import 'package:uuid/uuid.dart';

import 'anyinspect_receiver.dart';

abstract class AnyInspectConnection {
  final String id = const Uuid().v4();
  final Map<String, List<AnyInspectReceiver>> receivers = HashMap();

  /// Whether or not the `AnyInspectConnection` is connected to the server.
  bool get connected;

  /// Whether or not the `AnyInspectConnection` is disconnected from the server.
  bool get disconnected;

  Future<void> connect();

  Future<void> disconnect();

  void send(String method, Object params);

  void receive(String method, AnyInspectReceiver receiver) {
    receivers.putIfAbsent(method, () => <AnyInspectReceiver>[]);
    receivers[method]!.add(receiver);
  }
}
