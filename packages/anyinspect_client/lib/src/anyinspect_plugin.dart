import 'anyinspect_connection.dart';

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

  String get id;
  AnyInspectConnection get connection {
    if (_connection == null) {
      throw UnimplementedError();
    }
    return _connection!;
  }

  void onConnect(AnyInspectConnection connection) {
    _connection = connection;
  }

  void onDisconnect() {
    _connection = null;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
    };
  }
}
