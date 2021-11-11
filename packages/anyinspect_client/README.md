# anyinspect_client

[![pub version][pub-image]][pub-url]

[pub-image]: https://img.shields.io/pub/v/anyinspect_client.svg
[pub-url]: https://pub.dev/packages/anyinspect_client

AnyInspect client.

[![Discord](https://img.shields.io/badge/discord-%237289DA.svg?style=for-the-badge&logo=discord&logoColor=white)](https://discord.gg/uJcUXQrs)

---

## Quick Start

### Installation

```yaml
dependencies:
  anyinspect_client: ^0.1.0
```

## Usage

```dart
import 'package:anyinspect_client/anyinspect_client.dart';

Future<void> main(List<String> args) async {
  AnyInspectClient client = AnyInspectClient(plugins: []);
  // client.connection = xxx;
  await client.connect();
}
```
