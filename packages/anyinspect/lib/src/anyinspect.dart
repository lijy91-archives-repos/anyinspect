import 'dart:async';
import 'dart:io';

import 'package:anyinspect_client/anyinspect_client.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'anyinspect_connection_impl_ws.dart';

class AnyInspect with AnyInspectClientListener {
  AnyInspect._() {
    _client.addListener(this);
    _client.setConnection(AnyInspectConnectionImplWs());
  }

  /// The shared instance of [AnyInspect].
  static final AnyInspect instance = AnyInspect._();

  final AnyInspectClient _client = AnyInspectClient(plugins: []);

  bool _autoReconnect = false;
  Timer? _reconnectTimer;

  List<AnyInspectPlugin> get allPlugins => _client.plugins.toList();

  void addPlugin(AnyInspectPlugin plugin) {
    _client.plugins.add(plugin);
  }

  void removePlugin(AnyInspectPlugin plugin) {
    _client.plugins.remove(plugin);
  }

  AnyInspectPlugin getPlugin(String pluginId) {
    return _client.plugins.firstWhere((e) => e.id == pluginId);
  }

  Future<void> start({bool autoReconnect = false}) async {
    _autoReconnect = autoReconnect;

    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    _client.appIdentifier = packageInfo.packageName;
    _client.appName = packageInfo.appName;
    _client.appVersion = packageInfo.version;
    _client.appBuildNumber = packageInfo.buildNumber;

    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidDeviceInfo = await deviceInfoPlugin.androidInfo;
      _client.deviceId = androidDeviceInfo.id;
      _client.deviceName = androidDeviceInfo.display;
      _client.deviceIsPhysical = androidDeviceInfo.isPhysicalDevice;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfoPlugin.iosInfo;
      _client.deviceId = iosInfo.identifierForVendor;
      _client.deviceName = iosInfo.name;
      _client.deviceIsPhysical = iosInfo.isPhysicalDevice;
      // } else if (Platform.isLinux) {
      //   LinuxDeviceInfo linuxDeviceInfo = await deviceInfoPlugin.linuxInfo;
      //   _client.deviceId = linuxDeviceInfo.id;
    } else if (Platform.isMacOS) {
      MacOsDeviceInfo macOsDeviceInfo = await deviceInfoPlugin.macOsInfo;
      _client.deviceId = macOsDeviceInfo.systemGUID;
      _client.deviceName = macOsDeviceInfo.computerName;
    } else if (Platform.isWindows) {
      WindowsDeviceInfo windowsDeviceInfo = await deviceInfoPlugin.windowsInfo;
      _client.deviceName = windowsDeviceInfo.computerName;
    }

    _client.deviceSystem = Platform.operatingSystem;
    _client.deviceSystemVersion = Platform.operatingSystemVersion;

    await _reconnect();
  }

  Future<void> stop() async {}

  Future<void> _reconnect() async {
    await _client.connect();
  }

  @override
  void onConnect(AnyInspectClient client) {
    print('onConnect');
  }

  @override
  void onDisconnect(AnyInspectClient client) {
    print('onDisconnect');
    if (_autoReconnect) {
      _reconnectTimer = Timer(const Duration(seconds: 2), () async {
        if (_reconnectTimer != null || _reconnectTimer!.isActive) {
          _reconnectTimer!.cancel();
          _reconnectTimer = null;
        }
        await _reconnect();
      });
    }
  }
}
