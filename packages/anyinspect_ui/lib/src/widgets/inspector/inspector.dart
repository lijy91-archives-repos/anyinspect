import 'package:flutter/material.dart';
import 'package:multi_split_view/multi_split_view.dart';

import '../panel/panel.dart';

class Inspector extends StatelessWidget {
  final Widget child;
  final Widget? detailView;

  const Inspector({
    Key? key,
    required this.child,
    this.detailView,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<double> initialWeights = [];
    if (detailView != null) {
      initialWeights = [
        (size.width - 280 - 280) / size.width,
        280 / size.width,
      ];
    }
    return Container(
      width: double.infinity,
      height: double.infinity,
      margin: const EdgeInsets.only(top: 14, bottom: 14),
      child: MultiSplitView(
        children: [
          Panel(
            child: child,
          ),
          if (detailView != null)
            Panel(
              child: detailView!,
            ),
        ],
        controller: MultiSplitViewController(
          initialWeights: initialWeights,
        ),
      ),
    );
  }
}
