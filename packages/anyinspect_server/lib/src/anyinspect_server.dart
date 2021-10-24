import 'dart:async';

import 'package:anyinspect_client/anyinspect_client.dart';
import 'package:collection/collection.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_web_socket/shelf_web_socket.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'anyinspect_connection_impl_wsc.dart';
import 'anyinspect_server_listener.dart';

class AnyInspectServer {
  AnyInspectServer._();

  /// The shared instance of [AnyInspectServer].
  static final AnyInspectServer instance = AnyInspectServer._();

  final List<AnyInspectServerListener> _listeners = [];
  final List<AnyInspectClient> _clients = [];

  bool get hasListeners {
    return _listeners.isNotEmpty;
  }

  void addListener(AnyInspectServerListener listener) {
    _listeners.add(listener);
  }

  void removeListener(AnyInspectServerListener listener) {
    _listeners.remove(listener);
  }

  List<AnyInspectClient> get allClients => _clients;

  Future<void> start({
    String address = 'localhost',
    int port = 7700,
  }) async {
    final handler = webSocketHandler(
      (WebSocketChannel channel) {
        final conn = AnyInspectConnectionImplWsc(channel);
        conn.receive('connect', (d) => _handleClientConnect(conn, d));
        conn.receive('disconnect', (d) => _handleClientDisconnect(conn, d));
        conn.connect();
      },
    );
    shelf_io.serve(handler, address, port).then((server) {
      print('Serving at ws://${server.address.host}:${server.port}');
    });
  }

  _handleClientConnect(AnyInspectConnection connection, dynamic data) {
    final client = AnyInspectClient.fromJson(Map<String, dynamic>.from(data));
    client.setConnection(connection);
    _clients.add(client);

    for (var listener in _listeners) {
      listener.onClientConnect(client);
    }
  }

  _handleClientDisconnect(AnyInspectConnection connection, dynamic data) {
    final client = _clients.firstWhereOrNull(
      (e) => e.connection.id == connection.id,
    );
    if (client == null) return;
    _clients.remove(client);

    for (var listener in _listeners) {
      listener.onClientDisconnect(client);
    }
  }
}
