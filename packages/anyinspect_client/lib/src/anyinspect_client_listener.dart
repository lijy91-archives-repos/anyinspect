import 'package:anyinspect_client/anyinspect_client.dart';

abstract class AnyInspectClientListener {
  void onConnect(AnyInspectClient client) {}
  void onDisconnect(AnyInspectClient client) {}
}
