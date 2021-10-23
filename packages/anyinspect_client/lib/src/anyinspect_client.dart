import 'package:uuid/uuid.dart';

import 'anyinspect_connection.dart';
import 'anyinspect_plugin.dart';

class AnyInspectClient {
  String id = const Uuid().v4();

  String? appIdentifier;
  String? appName;
  String? appVersion;
  String? appBuildNumber;
  String? deviceId;
  bool? deviceIsPhysical;
  String? deviceSystem;
  String? deviceSystemVersion;
  List<AnyInspectPlugin> plugins;

  late AnyInspectConnection connection;

  AnyInspectClient({
    String? id,
    this.appIdentifier,
    this.appName,
    this.appVersion,
    this.appBuildNumber,
    this.deviceId,
    this.deviceIsPhysical,
    this.deviceSystem,
    this.deviceSystemVersion,
    this.plugins = const [],
  }) {
    if (id != null) this.id = id;
  }

  /// Whether or not the client is connected to the server.
  bool get connected => connection.connected;

  /// Whether or not the client is disconnected from the server.
  bool get disconnected => connection.disconnected;

  Future<void> connect() async {
    await connection.connect();
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
      'deviceIsPhysical': deviceIsPhysical,
      'deviceSystem': deviceSystem,
      'deviceSystemVersion': deviceSystemVersion,
      'plugins': plugins.map((e) => e.toJson()).toList(),
    };
  }
}
