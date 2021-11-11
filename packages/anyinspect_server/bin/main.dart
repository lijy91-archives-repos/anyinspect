import 'package:anyinspect_client/anyinspect_client.dart';
import 'package:anyinspect_server/anyinspect_server.dart';

class AnyInspectServerBlockListener extends AnyInspectServerListener {
  late Function(AnyInspectClient client) _onClientConnect;
  late Function(AnyInspectClient client) _onClientDisconnect;

  AnyInspectServerBlockListener({
    required onClientConnect,
    required onClientDisconnect,
  }) {
    _onClientConnect = onClientConnect;
    _onClientDisconnect = onClientDisconnect;
  }

  @override
  void onClientConnect(AnyInspectClient client) {
    _onClientConnect(client);
  }

  @override
  void onClientDisconnect(AnyInspectClient client) {
    _onClientDisconnect(client);
  }
}

Future<void> main(List<String> args) async {
  AnyInspectServer anyInspectServer = AnyInspectServer.instance;
  anyInspectServer.addListener(AnyInspectServerBlockListener(
    onClientConnect: (AnyInspectClient client) {
      print('[anyinspect] on-client-connect');
      print(client.toJson());
    },
    onClientDisconnect: (AnyInspectClient client) {
      print('[anyinspect] on-client-disconnect');
      print(client.toJson());
    },
  ));
  await anyInspectServer.start(
    address: '127.0.0.1',
    port: 7700,
  );
}
