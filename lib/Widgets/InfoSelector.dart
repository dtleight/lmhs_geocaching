import 'package:flutter/material.dart';
import 'package:lmhsgeocaching/Objects/Cache.dart';
import 'package:lmhsgeocaching/Utilities/ColorTheme.dart';

class InfoSelector extends StatefulWidget {
  final Cache cache;

  InfoSelector(this.cache);

  @override
  _InfoSelectorState createState() => _InfoSelectorState();
}

class _InfoSelectorState extends State<InfoSelector> {
  int _activeItemIndex = 0;
  final PageController _pageController = PageController();

  late List textOptions;
  late String activeText;

  @override
  void initState() {
    super.initState();
    textOptions = [
      widget.cache.description,
      widget.cache.instructions,
    ];
    activeText = textOptions[_activeItemIndex];
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
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
      BottomNavigationBar(
        backgroundColor: ColorTheme.backgroundColor,
        currentIndex: _activeItemIndex,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Container(),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Container(),
            label: 'Instructions',
          ),
        ],
        onTap: (int value) {
          setState(() {
            _activeItemIndex = value;
            activeText = textOptions[value];
          });
          _pageController.animateToPage(
            value,
            duration: Duration(milliseconds: 300),
            curve: Curves.ease,
          );
        },
        selectedItemColor: ColorTheme.textColor,
        selectedFontSize: 22,
        unselectedFontSize: 20,
      ),
    ]);
  }
}
