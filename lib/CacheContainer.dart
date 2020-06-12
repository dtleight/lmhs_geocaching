import 'package:flutter/cupertino.dart';
import 'package:lmhsgeocaching/CompassPage.dart';
import 'CacheInfoPage.dart';
import 'CompassPage.dart';

class CacheContainer extends StatefulWidget {
  @override
  _PageViewDemoState createState() => _PageViewDemoState();
}

class _PageViewDemoState extends State<CacheContainer> {
  PageController _controller = PageController(
    initialPage: 1,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _controller,
      children: [
        CacheInfoPage(),
        CompassPage(),
      ],
    );
  }
}