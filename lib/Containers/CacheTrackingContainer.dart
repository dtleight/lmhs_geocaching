import 'package:flutter/cupertino.dart';
import '../Pages/CompassPage.dart';
import '../Pages/CacheInfoPage.dart';
import '../Pages/CacheNearbyPage.dart';
import '../Objects/Cache.dart';

class CacheContainer extends StatefulWidget {
  final Cache cache;

  CacheContainer(this.cache);

  @override
  CacheContainerState createState() => CacheContainerState();
}

class CacheContainerState extends State<CacheContainer> {

  PageController _controller = PageController(initialPage: 1);

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
        CacheInfoPage(widget.cache),
        CompassPage(widget.cache),
        CacheNearbyPage(widget.cache),
        //CompletionTestPage(cache),
      ],
    );
  }
}
