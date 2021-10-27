import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:anyinspect_client/anyinspect_client.dart';

class AnyInspectConnectionImplWs extends AnyInspectConnection {
  WebSocket? _webSocket;

  String? _serverUrl;

  void setServerUrl(String serverUrl) {
    _serverUrl = serverUrl;
  }

  @override
  bool get connected => _webSocket != null;

  @override
  bool get disconnected => _webSocket == null;

  @override
  Future<void> connect() async {
    _webSocket ??= await WebSocket.connect(_serverUrl!);
    _webSocket!.listen(
      (event) {
        final map = json.decode(event);
        final method = map['method'];
        final params = map['params'];
        notifyReceivers(method, params);
      },
      onDone: () async {
        notifyReceivers('disconnect', {});
        _webSocket = null;
      },
    );
    notifyReceivers('connect', {});
  }

  @override
  Future<void> disconnect() async {
    _webSocket = null;
  }

  @override
  void send(String method, dynamic params) {
    _webSocket!.add(json.encode({
      'method': method,
      'params': params,
    }));
  }
}
