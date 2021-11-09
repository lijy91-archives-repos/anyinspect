# anyinspect_server

[![pub version][pub-image]][pub-url]

[pub-image]: https://img.shields.io/pub/v/anyinspect_server.svg
[pub-url]: https://pub.dev/packages/anyinspect_server

## Quick Start

### Installation

```yaml
dependencies:
  anyinspect_server: ^0.0.2
```

## Usage

```dart
import 'package:anyinspect_server/anyinspect_server.dart';

Future<void> main(List<String> args) async {
  AnyInspectServer anyInspectServer = AnyInspectServer.instance;
  await anyInspectServer.start();
}
```
