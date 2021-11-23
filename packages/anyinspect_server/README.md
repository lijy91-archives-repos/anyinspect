# anyinspect_server

[![pub version][pub-image]][pub-url]

[pub-image]: https://img.shields.io/pub/v/anyinspect_server.svg
[pub-url]: https://pub.dev/packages/anyinspect_server

AnyInspect server.

[![Discord](https://img.shields.io/badge/discord-%237289DA.svg?style=for-the-badge&logo=discord&logoColor=white)](https://discord.gg/RzFrAhmXFY)

---

## Quick Start

### Installation

```yaml
dependencies:
  anyinspect_server: ^0.1.0
```

## Usage

```dart
import 'package:anyinspect_server/anyinspect_server.dart';

Future<void> main(List<String> args) async {
  AnyInspectServer anyInspectServer = AnyInspectServer.instance;
  await anyInspectServer.start();
}
```
