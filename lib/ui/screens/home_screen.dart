import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/ui/widget/new_todo_input_widget.dart';
import 'package:todoapp/ui/widget/todo_list_builder.dart';
import 'package:todoapp/ui/widget/done_todo_list_builder.dart';
import '../../main.dart';
import 'package:intl/intl.dart';
import '../../data/moor_database.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool showCompleted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomAppBar(
          child: Container(
            height: 65.0,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  iconSize: 32.0,
                  padding: EdgeInsets.only(left: 24.0),
                  icon: Icon(Icons.menu),
                  onPressed: () {},
                ),
                IconButton(
                  iconSize: 32.0,
                  padding: EdgeInsets.only(right: 24.0),
                  icon: Icon(Icons.more_vert),
                  onPressed: () {},
                )
              ],
            ),
          ),
          elevation: 20.0,
          shape: CircularNotchedRectangle(),
        ),
        resizeToAvoidBottomPadding: false,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: NewTodoInput(),
        body: Padding(
          padding: const EdgeInsets.only(top: 32.0),
          child: Column(
            children: <Widget>[
              Container(
                child: Text(
                  'To-do List',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 32.0,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Container(
                    // color: Colors.red,
                    child: getDayList(),
                  ),
                ),
              ),
              Expanded(
                flex: 7,
                child: TodoListBuilder(),
                // TODO ExpansionTile()
              ),
            ],
          ),
        ));
  }

  Widget getDayList() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1.0),
      child: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Container(
              height: 100.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Container(
                    width: 100.0,
                    child: Card(
                      color: Colors.white70,
                      child: Text(getDate(index)),
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  String getDate(int index) {
    var rawTodayDate = DateTime.now();

    var rawDate = rawTodayDate.add(Duration(days: index - 1));
    var formatedDate = DateFormat.EEEE().format(rawDate);

    if (index == 0) {
      formatedDate = 'Yesterday';
    } else if (index == 1) {
      formatedDate = 'Today';
    } else if (index == 2) {
      formatedDate = 'Tommorow';
    }

    return formatedDate;
  }

  Row _buildCompletedOnlySwitch() {
    return Row(
      children: <Widget>[
        Text('Completed only'),
        Switch(
            value: showCompleted,
            activeColor: Colors.blueAccent,
            onChanged: (newValue) {
              setState(() {
                showCompleted = newValue;
              });
            })
      ],
    );
  }
}
