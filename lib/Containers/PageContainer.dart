import 'package:flutter/cupertino.dart';
import '../Pages/CachePage.dart';
import '../Pages/HomePage.dart';
import 'UtilitySelector.dart';

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

  /* todo: I (ben) need to switch out the controller with the button widget i made*/
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _controller,
      children: [
        HomePage(title: 'Lower Macungie Historical Society Geocaching'),
        CachePage(),
        //UtilitySelector(),
      ],
    );
  }
}