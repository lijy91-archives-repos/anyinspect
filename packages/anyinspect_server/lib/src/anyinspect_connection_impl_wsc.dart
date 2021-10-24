import 'dart:convert';

import 'package:anyinspect_client/anyinspect_client.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class AnyInspectConnectionImplWsc extends AnyInspectConnection {
  final WebSocketChannel _channel;

  AnyInspectConnectionImplWsc(this._channel);

  @override
  bool get connected => _channel.closeCode == null;

  @override
  bool get disconnected => _channel.closeCode != null;

  @override
  Future<void> connect() async {
    _channel.stream.listen(
      (event) {
        final map = json.decode(event);
        final method = map['method'];
        final params = map['params'];
        notifyReceivers(method, params);
      },
      onDone: () {
        notifyReceivers('disconnect', {});
      },
    );
  }

  @override
  Future<void> disconnect() {
    throw UnimplementedError();
  }

  @override
  void send(String method, dynamic params) {
    _channel.sink.add(json.encode({
      'method': method,
      'params': params,
    }));
  }
}
