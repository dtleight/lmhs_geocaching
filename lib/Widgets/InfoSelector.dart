import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lmhsgeocaching/Objects/Cache.dart';
import 'package:lmhsgeocaching/Utilities/ColorTheme.dart';
import 'package:text_item_selector/text_item_selector.dart';

class InfoSelector extends StatefulWidget {
  final Cache cache;

  InfoSelector(this.cache);

  @override
  _InfoSelectorState createState() => _InfoSelectorState();
}

class _InfoSelectorState extends State<InfoSelector> {
  int _activeItem;
  PageController _pageController;

  Cache cache;
  List textOptions;
  String activeText;

  @override
  void initState() {
    super.initState();
    cache = widget.cache;

    _pageController = PageController();
    _activeItem = 0;
    textOptions = [
      cache.description,
      cache.instructions,
    ];
    activeText = textOptions[_activeItem];
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      ItemSelectorBar(
        backgroundColor: ColorTheme.backgroundColor,
        activeIndex: _activeItem,
        items: <String>[
          'History',
          'Instructions',
        ],
        onTap: (int value) {
          setState(() {
            _activeItem = value;
            activeText = textOptions[value];
          });
          _pageController.animateToPage(
            value,
            duration: Duration(milliseconds: 300),
            curve: Curves.ease,
          );
        },
        indicatorColor: ColorTheme.textColor,
        itemTextStyle: ItemTextStyle(
          initialStyle: TextStyle(
            color: ColorTheme.textColor,
            fontSize: 25,
            fontWeight: FontWeight.normal,
          ),
          selectedStyle: TextStyle(
            color: ColorTheme.textColor,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      Expanded(
        child: Container(
          width: double.infinity,
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
                child: Text(
                  '$activeText',
                  style: new TextStyle(
                    fontSize: 16.0,
                    color: ColorTheme.textColor,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
        ),
      ),
    ]);
  }
}
