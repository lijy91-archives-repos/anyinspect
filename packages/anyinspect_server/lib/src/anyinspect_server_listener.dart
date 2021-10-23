import 'package:anyinspect_client/anyinspect_client.dart';

abstract class AnyInspectServerListener {
  void onClientConnect(AnyInspectClient client) {}
  void onClientDisconnect(AnyInspectClient client) {}
}
