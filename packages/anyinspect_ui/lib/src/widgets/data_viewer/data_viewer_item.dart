import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DataViewerItem extends StatelessWidget {
  final Widget title;
  final Widget detailText;

  const DataViewerItem({
    Key? key,
    required this.title,
    required this.detailText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      padding: const EdgeInsets.only(
        left: 6,
        right: 6,
        top: 6,
        bottom: 6,
      ),
      child: Container(
        width: double.infinity,
        child: Row(
          children: [
            Expanded(
              child: DefaultTextStyle(
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).textTheme.bodyText2?.color,
                ),
                child: title,
              ),
            ),
            Expanded(
              child: DefaultTextStyle(
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).textTheme.bodyText2?.color,
                ),
                child: detailText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
