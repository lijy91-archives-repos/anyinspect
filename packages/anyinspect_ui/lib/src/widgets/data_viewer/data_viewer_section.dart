import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DataViewerSection extends StatefulWidget {
  final Widget title;
  final bool collapsible;
  final List<Widget> children;

  const DataViewerSection({
    Key? key,
    required this.title,
    this.collapsible = true,
    this.children = const [],
  }) : super(key: key);

  @override
  _DataViewerSectionState createState() => _DataViewerSectionState();
}

class _DataViewerSectionState extends State<DataViewerSection> {
  bool _isCollapsed = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _isCollapsed = !_isCollapsed;
            });
          },
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              border: Border(
                bottom: BorderSide(
                  color: Theme.of(context).dividerColor,
                  width: 1,
                ),
              ),
            ),
            constraints: const BoxConstraints(minHeight: 36),
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    left: 14,
                    right: 8,
                    top: 2,
                  ),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.fastOutSlowIn,
                    transformAlignment: Alignment.center,
                    transform: Matrix4.rotationZ(
                      _isCollapsed ? math.pi / 2 : 0,
                    ),
                    child: Icon(
                      CupertinoIcons.chevron_right,
                      size: 12,
                      color: Theme.of(context).textTheme.bodyText2!.color,
                    ),
                  ),
                ),
                DefaultTextStyle(
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyText2!.color,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                  child: widget.title,
                ),
                Expanded(child: Container()),
              ],
            ),
          ),
        ),
        AnimatedCrossFade(
          duration: const Duration(milliseconds: 200),
          firstChild: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: widget.children,
          ),
          secondChild: Container(),
          crossFadeState: _isCollapsed
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
        ),
      ],
    );
  }
}
