import 'package:flutter/material.dart';

class todoAdd extends StatelessWidget {
  todoAdd({Key key}) : super(key: key);

  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var width = screenSize.width;
    var height = screenSize.height * 0.3;
    return Material(
      child: Container(
        child: TextField(
          controller: textController,
          decoration: InputDecoration(
            hintText: 'New to-do',
          ),
        ),
      ),
    );
  }
}
