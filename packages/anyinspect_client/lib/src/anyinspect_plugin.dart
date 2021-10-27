import 'dart:collection';
import 'dart:convert';

import 'anyinspect_connection.dart';
import 'anyinspect_receiver.dart';

class AnyInspectPluginInfo extends AnyInspectPlugin {
  @override
  String get id => _id!;

  String? _id;

  AnyInspectPluginInfo({required String id}) {
    _id = id;
  }

  factory AnyInspectPluginInfo.fromJson(Map<String, dynamic> json) {
    return AnyInspectPluginInfo(
      id: json['id'],
    );
  }
}

abstract class AnyInspectPlugin {
  final Map<String, List<AnyInspectReceiver>> _receivers = HashMap();
  AnyInspectConnection? _connection;

  String get id;

  String get name => id
      .split('_')
      .map((e) => '${e.substring(0, 1).toUpperCase()}${e.substring(1)}')
      .join('');

  void setConnection(AnyInspectConnection connection) {
    _connection = connection;
    _connection!.receive('plugin_$id/messaging', (data) {
      final map = json.decode(data);
      final method = map['method'];
      final params = Map<String, dynamic>.from(map['params']);
      notifyReceivers(method, params);
    });
  }

  void send(String method, Object params) {
    _connection!.send(
      'plugin_$id/messaging',
      json.encode({
        'method': method,
        'params': params,
      }),
    );
  }

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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
    };
  }
}
