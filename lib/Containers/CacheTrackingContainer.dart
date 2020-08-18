import 'package:flutter/cupertino.dart';
import '../Pages/CompassPage.dart';
import '../Pages/CacheInfoPage.dart';
import '../Pages/CacheNearbyPage.dart';
import '../Pages/CompletionTestPage.dart';
import '../Objects/Cache.dart';

class CacheContainer extends StatefulWidget
{
Cache c;
  CacheContainer(Cache c)
  {
    this.c = c;
  }

  @override
  CacheContainerState createState() => CacheContainerState(c);
}

class CacheContainerState extends State<CacheContainer>
{
  Cache cache;
  CacheContainerState(Cache cache)
  {
    this.cache = cache;
  }

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
      children:
      [
        CacheInfoPage(cache),
        CompassPage(cache),
        CacheNearbyPage(cache: cache),
        CompletionTestPage(cache),
      ],
    );
  }
}