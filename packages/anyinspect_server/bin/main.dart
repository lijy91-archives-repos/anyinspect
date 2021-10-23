import 'package:anyinspect_client/anyinspect_client.dart';
import 'package:anyinspect_server/anyinspect_server.dart';

class AnyInspectServerListener2 extends AnyInspectServerListener {
  @override
  void onClientConnect(AnyInspectClient client) {
    print('>onClientConnect');
    print(client.toJson());
  }

  @override
  void onClientDisconnect(AnyInspectClient client) {
    print('>onClientDisconnect');
    print(client);
  }
}

Future<void> main(List<String> args) async {
  AnyInspectServer anyInspectServer = AnyInspectServer.instance;
  anyInspectServer.addListener(AnyInspectServerListener2());
  await anyInspectServer.start();
}
