import 'package:flutter/material.dart';
import 'package:todoapp/ui/screens/todo_list.dart';
import 'package:todoapp/ui/themeData.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
