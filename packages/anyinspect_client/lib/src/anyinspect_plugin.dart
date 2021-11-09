import 'dart:convert';

import 'anyinspect_connection.dart';

class AnyInspectPluginEvent {
  const AnyInspectPluginEvent(this.name, [this.arguments]);

  /// The name of the event.
  final String name;

  /// The arguments for the event.
  final dynamic arguments;
}

class AnyInspectPluginEventListener {
  void onEvent(AnyInspectPluginEvent event) {
    throw UnimplementedError();
  }
}

class AnyInspectPluginMethod {
  const AnyInspectPluginMethod(this.name, [this.arguments]);

  /// The name of the method.
  final String name;

  /// The arguments for the method.
  final dynamic arguments;
}

class AnyInspectPluginMethodHandler {
  Future<void> handleMethod(AnyInspectPluginMethod method) {
    throw UnimplementedError();
  }
}

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
  AnyInspectConnection? _connection;

  final List<AnyInspectPluginEventListener> _eventListeners = [];
  final List<AnyInspectPluginMethodHandler> _methodHandlers = [];

  String get id;

  String get name => id
      .split('_')
      .map((e) => '${e.substring(0, 1).toUpperCase()}${e.substring(1)}')
      .join('');

  void setConnection(AnyInspectConnection connection) {
    _connection = connection;
    _connection!.receive('plugin_$id/messaging', (data) {
      final map = json.decode(data);
      final type = map['type'];
      final name = map['name'];
      final arguments = Map<String, dynamic>.from(map['arguments']);

      if (type == 'event') {
        final event = AnyInspectPluginEvent(name, arguments);
        for (var i = 0; i < _eventListeners.length; i++)
          _eventListeners[i].onEvent(event);
      }
      if (type == 'method') {
        final method = AnyInspectPluginMethod(name, arguments);
        for (var i = 0; i < _methodHandlers.length; i++)
          _methodHandlers[i].handleMethod(method);
      }
    });
  }

  void addEventListener(AnyInspectPluginEventListener listener) {
    _eventListeners.add(listener);
  }

  void removeEventListener(AnyInspectPluginEventListener listener) {
    _eventListeners.remove(listener);
  }

  void addMethodHandler(AnyInspectPluginMethodHandler handler) {
    _methodHandlers.add(handler);
  }

  void removeMethodHandler(AnyInspectPluginMethodHandler handler) {
    _methodHandlers.remove(handler);
  }

  void emitEvent(String event, [dynamic arguments]) {
    _send(
      type: 'event',
      name: event,
      arguments: arguments ?? {},
    );
  }

  void callMethod(String method, [dynamic arguments]) {
    _send(
      type: 'method',
      name: method,
      arguments: arguments ?? {},
    );
  }

  void _send({
    required String type,
    required String name,
    required Object arguments,
  }) {
    _connection!.send(
      'plugin_$id/messaging',
      json.encode({
        'type': type,
        'name': name,
        'arguments': arguments,
      }),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
    };
  }
}
