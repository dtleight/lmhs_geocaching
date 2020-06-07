import 'package:flutter/cupertino.dart';
import 'CachePage.dart';
import 'HomePage.dart';
import 'CompassPage.dart';

class PageContainer extends StatefulWidget {
  @override
  _PageViewDemoState createState() => _PageViewDemoState();
}

class _PageViewDemoState extends State<PageContainer> {
  PageController _controller = PageController(
    initialPage: 0,
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
        HomePage(title: 'Lower Macungie Historical Society Geocaching'),
        CachePage(),
        CompassPage(),
      ],
    );
  }
}