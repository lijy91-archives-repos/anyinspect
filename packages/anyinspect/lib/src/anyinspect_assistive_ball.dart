import 'package:anyinspect/anyinspect.dart';
import 'package:anyinspect_client/anyinspect_client.dart';
import 'package:draggable_float_widget/draggable_float_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnyInspectAssistiveBall extends StatefulWidget {
  const AnyInspectAssistiveBall({
    Key? key,
  }) : super(key: key);

  @override
  _AnyInspectAssistiveBallState createState() =>
      _AnyInspectAssistiveBallState();
}

class _AnyInspectAssistiveBallState extends State<AnyInspectAssistiveBall>
    with AnyInspectClientListener {
  bool _connected = false;

  @override
  void initState() {
    AnyInspect.instance.client.addListener(this);
    super.initState();
    _init();
  }

  @override
  void dispose() {
    AnyInspect.instance.client.removeListener(this);
    super.dispose();
  }

  void _init() {
    _connected = AnyInspect.instance.client.connected;
  }

  void _handleClickAssistiveBall() async {
    if (!_connected) {
      await AnyInspect.instance.stop();
      await AnyInspect.instance.start();
    }
  }

  Widget _build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _connected
            ? Color(0xff0416ff4).withOpacity(0.8)
            : Colors.grey.withOpacity(0.6),
        borderRadius: BorderRadius.circular(20),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: Offset(0.0, 0.2),
            blurRadius: 1,
          ),
        ],
      ),
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: () => _handleClickAssistiveBall(),
        child: Center(
          child: AnyInspectLogo(
            color: Colors.white,
            size: 26,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DraggableFloatWidget(
      width: 40,
      height: 40,
      child: _build(context),
      config: DraggableFloatWidgetBaseConfig(
        initPositionXInLeft: false,
        initPositionYInTop: false,
        initPositionYMarginBorder: 0,
        borderTopContainTopBar: false,
        borderLeft: 10,
        borderRight: 10,
        borderTop: 20,
        borderBottom: 20,
      ),
    );
  }

  void onConnect(AnyInspectClient client) {
    _connected = true;
    setState(() {});
  }

  void onDisconnect(AnyInspectClient client) {
    _connected = false;
    setState(() {});
  }
}

class AnyInspectAssistiveBallManager {
  OverlayEntry? _overlayEntry;

  void show(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _show(context);
    });
  }

  void _show(BuildContext context) {
    _hide();
    _overlayEntry = OverlayEntry(builder: (context) {
      return AnyInspectAssistiveBall();
    });
    Overlay.of(context)?.insert(_overlayEntry!);
  }

  void _hide() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}
