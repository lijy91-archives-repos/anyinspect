import 'dart:collection';

import 'package:uuid/uuid.dart';

import 'anyinspect_receiver.dart';

abstract class AnyInspectConnection {
  final Map<String, List<AnyInspectReceiver>> _receivers = HashMap();

  final String id = const Uuid().v4();

  /// Whether or not the `AnyInspectConnection` is connected to the server.
  bool get connected;

  /// Whether or not the `AnyInspectConnection` is disconnected from the server.
  bool get disconnected;

  Future<void> connect();

  Future<void> disconnect();

  void send(String method, Object params);

  void receive(String method, AnyInspectReceiver receiver) {
    _receivers.putIfAbsent(method, () => <AnyInspectReceiver>[]);
    _receivers[method]!.add(receiver);
  }

  void notifyReceivers(String method, dynamic params) {
    if (_receivers.containsKey(method)) {
      List<AnyInspectReceiver> l = _receivers[method]!;
      for (var i = 0; i < l.length; i++) {
        l[i](params);
      }
    } else {
      print(method);
      print(params);
    }
  }
}
