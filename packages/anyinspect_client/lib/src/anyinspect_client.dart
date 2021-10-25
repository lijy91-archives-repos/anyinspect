import 'package:uuid/uuid.dart';

import 'anyinspect_client_listener.dart';
import 'anyinspect_connection.dart';
import 'anyinspect_plugin.dart';

class AnyInspectClient {
  String id = const Uuid().v4();

  String? appIdentifier;
  String? appName;
  String? appVersion;
  String? appBuildNumber;
  String? deviceId;
  String? deviceName;
  bool? deviceIsPhysical;
  String? deviceSystem;
  String? deviceSystemVersion;
  List<AnyInspectPlugin> plugins;

  AnyInspectClient({
    String? id,
    this.appIdentifier,
    this.appName,
    this.appVersion,
    this.appBuildNumber,
    this.deviceId,
    this.deviceName,
    this.deviceIsPhysical,
    this.deviceSystem,
    this.deviceSystemVersion,
    this.plugins = const [],
  }) {
    if (id != null) this.id = id;
  }

  AnyInspectConnection? _connection;
  final List<AnyInspectClientListener> _listeners = [];

  void setConnection(AnyInspectConnection connection) {
    _connection = connection;

    // Listening
    connection.receive('connect', (_) {
      for (var listener in _listeners) {
        listener.onConnect(this);
      }
      for (var i = 0; i < plugins.length; i++) {
        plugins[i].setConnection(connection);
      }
    });
    connection.receive('disconnect', (_) {
      for (var listener in _listeners) {
        listener.onDisconnect(this);
      }
    });
  }

  AnyInspectConnection get connection => _connection!;

  bool get hasListeners {
    return _listeners.isNotEmpty;
  }

  void addListener(AnyInspectClientListener listener) {
    _listeners.add(listener);
  }

  void removeListener(AnyInspectClientListener listener) {
    _listeners.remove(listener);
  }

  /// Whether or not the client is connected to the server.
  bool get connected => connection.connected;

  /// Whether or not the client is disconnected from the server.
  bool get disconnected => connection.disconnected;

  Future<void> connect() async {
    await connection.connect();
    if (connection.connected) {
      connection.send('connect', this.toJson());
    }
  }

  Future<void> disconnect() async {
    await connection.disconnect();
  }

  factory AnyInspectClient.fromJson(Map<String, dynamic> json) {
    return AnyInspectClient(
      id: json['id'],
      appIdentifier: json['appIdentifier'],
      appName: json['appName'],
      appVersion: json['appVersion'],
      appBuildNumber: json['appBuildNumber'],
      deviceId: json['deviceId'],
      deviceName: json['deviceName'],
      deviceIsPhysical: json['deviceIsPhysical'],
      deviceSystem: json['deviceSystem'],
      deviceSystemVersion: json['deviceSystemVersion'],
      plugins: List<dynamic>.from(json['plugins'])
          .map((e) => AnyInspectPluginInfo.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'appIdentifier': appIdentifier,
      'appName': appName,
      'appVersion': appVersion,
      'appBuildNumber': appBuildNumber,
      'deviceId': deviceId,
      'deviceName': deviceName,
      'deviceIsPhysical': deviceIsPhysical,
      'deviceSystem': deviceSystem,
      'deviceSystemVersion': deviceSystemVersion,
      'plugins': plugins.map((e) => e.toJson()).toList(),
    };
  }
}
