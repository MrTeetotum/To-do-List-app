import 'package:flutter/material.dart';
import 'package:todoapp/data/moor_database.dart';
import 'package:todoapp/ui/screens/todo_list.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final db = AppDatabase();
    return MultiProvider(
      providers: [
        Provider(builder: (_) => db.todoDao),
        Provider(builder: (_) => db.tagDao),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        home: MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}
