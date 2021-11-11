# anyinspect

[![pub version][pub-image]][pub-url]

[pub-image]: https://img.shields.io/pub/v/anyinspect.svg
[pub-url]: https://pub.dev/packages/anyinspect

AnyInspect integration kit.

[![Discord](https://img.shields.io/badge/discord-%237289DA.svg?style=for-the-badge&logo=discord&logoColor=white)](https://discord.gg/uJcUXQrs)

---

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [anyinspect](#anyinspect)
  - [Quick Start](#quick-start)
    - [Installation](#installation)
  - [Usage](#usage)
    - [Show assistive ball](#show-assistive-ball)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Quick Start

### Installation

```yaml
dependencies:
  anyinspect: ^0.1.0
```

## Usage

```dart
import 'package:anyinspect/anyinspect.dart';
import 'package:anyinspect_plugin_database/anyinspect_plugin_database.dart';
import 'package:anyinspect_plugin_network/anyinspect_plugin_network.dart';
import 'package:anyinspect_plugin_shared_preferences/anyinspect_plugin_shared_preferences.dart';
import 'package:flutter/foundation.dart';

Future<void> main(List<String> args) async {
  if (!kReleaseMode) {
    AnyInspect anyInspect = AnyInspect.instance;
    anyInspect.addPlugin(AnyInspectPluginDatabase());
    anyInspect.addPlugin(AnyInspectPluginNetwork());
    anyInspect.addPlugin(AnyInspectPluginSharedPreferences());
    anyInspect.start();
  }
  
  // ...
}
```

### Show assistive ball

```dart
import 'package:anyinspect/anyinspect.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    if (!kReleaseMode) {
      // Show assistive ball in your first page.
      AnyInspect.instance.assistiveBall.show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    // ...
  }
}
```