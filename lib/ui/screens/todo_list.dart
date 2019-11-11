import 'package:flutter/material.dart';
import '../../main.dart';
import 'package:todoapp/ui/themeData.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/ui/screens/todo_add.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        foregroundColor: Colors.blue,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => todoAdd()),
          );
        },
        tooltip: 'Add a task',
        child: Icon(
          Icons.add,
          size: 40.0,
        ),
      ),
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
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Container(
                  child: getDayList(),
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(child: getTodoList()),
            ),
          ],
        ),
      ),
    );
  }

  Widget getDayList() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
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

  CustomScrollView getTodoList() {
    int length = 20;
    var items = List.generate(50, (int index) => index);

    return CustomScrollView(
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildListDelegate(
            List<Dismissible>.generate(
              length,
              (int index) {
                return new Dismissible(
                  direction: DismissDirection.startToEnd,
                  key: Key(items.toString()),
                  onDismissed: (direction) {
                    print("$index is deleted");
                    items.removeAt(index);
                  },
                  background: Container(
                    color: Colors.red,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      ListTile(
                        leading: Radio(
                          value: false,
                          onChanged: (bool newValue) {
                            setState(() {});
                          },
                        ),
                        title: Text(
                          'Item ${index.toString()}',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                      Divider(
                        height: 8.0,
                        color: Color.fromRGBO(150, 150, 150, 0.8),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  // List _buildList(int count) {
  //   List<Widget> listItems = List();

  //   for (int i = 0; i < count; i++) {
  //     listItems.add(Column(
  //       children: <Widget>[
  //         ListTile(
  //           leading: Radio(
  //             value: false,
  //             onChanged: (bool newValue) {
  //               setState(() {});
  //             },
  //           ),
  //           title: Text(
  //             'Item ${i.toString()}',
  //             style: TextStyle(fontSize: 16.0),
  //           ),
  //         ),
  //         Divider(
  //           height: 8.0,
  //           color: Color.fromRGBO(150, 150, 150, 0.8),
  //         ),
  //       ],
  //     ));
  //   }

  //   return listItems;
  // }
}
