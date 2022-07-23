import 'package:flutter/material.dart';

class Selector extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SelectorState();
  }
}

class SelectorState extends State<Selector> {
  String text = "String 1";
  List<String> texts = ["String 1", "String 2"];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Divider(
            thickness: 0.2,
            color: Colors.blue,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: FlatButton(
                  onPressed: () => onButtonPressed(0),
                  child: Text("One"),
                ),
              ),
              //SizedBox(height: 50.0,width: 0.4,child: Container(color: Colors.blue,),),
              Expanded(
                child: FlatButton(
                  onPressed: () => onButtonPressed(1),
                  child: Text("Two"),
                ),
              )
            ],
          ),
          Divider(
            thickness: 0.4,
            color: Colors.blue,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Text(text),
            ),
          )
        ],
      ),
    );
  }

  void onButtonPressed(int buttonID) {
    setState(() => text = texts[buttonID]);
  }
}
