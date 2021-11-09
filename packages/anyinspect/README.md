# anyinspect

[![pub version][pub-image]][pub-url]

[pub-image]: https://img.shields.io/pub/v/anyinspect.svg
[pub-url]: https://pub.dev/packages/anyinspect

## Quick Start

### Installation

```yaml
dependencies:
  anyinspect: ^0.0.2
```

## Usage

```dart
import 'package:anyinspect/anyinspect.dart';
import 'package:anyinspect_plugin_database/anyinspect_plugin_database.dart';
import 'package:anyinspect_plugin_network/anyinspect_plugin_network.dart';
import 'package:anyinspect_plugin_shared_preferences/anyinspect_plugin_shared_preferences.dart';

Future<void> main(List<String> args) async {
  AnyInspect anyInspect = AnyInspect.instance;
  anyInspect.addPlugin(AnyInspectPluginDatabase());
  anyInspect.addPlugin(AnyInspectPluginNetwork());
  anyInspect.addPlugin(AnyInspectPluginSharedPreferences());
  anyInspect.start(autoReconnect: true);
  
  // ...
}
```
