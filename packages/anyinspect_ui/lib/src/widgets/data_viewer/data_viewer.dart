import 'package:flutter/material.dart';

export 'data_viewer_item.dart';
export 'data_viewer_section.dart';

class DataViewer extends StatelessWidget {
  final List<Widget> children;

  const DataViewer({
    Key? key,
    this.children = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: ScrollController(),
      children: children,
    );
  }
}
