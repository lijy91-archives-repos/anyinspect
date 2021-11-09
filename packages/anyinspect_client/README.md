# anyinspect_client

[![pub version][pub-image]][pub-url]

[pub-image]: https://img.shields.io/pub/v/anyinspect_client.svg
[pub-url]: https://pub.dev/packages/anyinspect_client

## Quick Start

### Installation

```yaml
dependencies:
  anyinspect_client: ^0.0.2
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
