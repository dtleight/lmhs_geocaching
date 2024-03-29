import 'package:flutter/material.dart';
import 'package:lmhsgeocaching/Objects/Cache.dart';

class LogBook extends StatefulWidget {
  final Cache cache;

  LogBook(this.cache);

  @override
  State<LogBook> createState() => LogBookState();
}

class LogBookState extends State<LogBook> {
  bool isHintVisible = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(
            widget.cache.instructions,
          ),
          ElevatedButton(
            onPressed: () => setState(() => isHintVisible = !isHintVisible),
            child: Text(isHintVisible ? "Hide hint" : "Show hint"),
          ),
          Visibility(
            visible: isHintVisible,
            child: Text(widget.cache.hint),
          )
        ],
      ),
    );
  }
}
