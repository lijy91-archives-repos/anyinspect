import 'package:flutter/material.dart';
import 'package:multi_split_view/multi_split_view.dart';

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
      color: Theme.of(context).canvasColor,
      width: double.infinity,
      height: double.infinity,
      child: MultiSplitView(
        children: [
          child,
          if (detailView != null) detailView!,
        ],
        controller: MultiSplitViewController(
          weights: initialWeights,
        ),
      ),
    );
  }
}
