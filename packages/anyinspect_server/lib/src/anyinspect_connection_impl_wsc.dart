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
        try {
          final map = json.decode(event);
          String method = map['method'];
          Map<String, dynamic> params =
              Map<String, dynamic>.from(map['params']);

          for (var receiver in receivers[method]!) {
            receiver(params);
          }
        } catch (error) {
          print(error);
        }
      },
      onDone: () {
        String method = 'disconnect';
        for (var receiver in receivers[method]!) {
          receiver({});
        }
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
