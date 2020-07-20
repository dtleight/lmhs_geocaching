import 'package:flutter/cupertino.dart';
import 'package:lmhsgeocaching/CompassPage.dart';
import 'Cache.dart';
import 'CacheInfoPage.dart';
import 'CompassPage.dart';
import 'CompletionTestPage.dart';

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

  PageController _controller = PageController(initialPage: 1,);

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
        //CompassPage(cache),
        CompletionTestPage()
      ],
    );
  }
}