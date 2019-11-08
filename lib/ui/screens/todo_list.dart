import 'package:flutter/material.dart';
import '../../main.dart';
import 'package:todoapp/ui/themeData.dart';

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
        onPressed: () {},
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
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Container(
                  child: getDayList(),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: getTodoList(),
            ),
          ],
        ),
      ),
    );
  }

  List _buildList(int count) {
    List<Widget> listItems = List();

    for (int i = 0; i < count; i++) {
      listItems.add(
        Padding(
          padding: EdgeInsets.all(20.0),
          child: Text(
            'Item ${i.toString()}',
            style: TextStyle(fontSize: 25.0),
          ),
        ),
      );
    }

    return listItems;
  }

  Widget getDayList() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Container(
              height: 80.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Container(
                    width: 80.0,
                    child: Card(
                      color: Colors.white70,
                      child: Text('data'),
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

  CustomScrollView getTodoList() {
    return CustomScrollView(
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildListDelegate(_buildList(50)),
        ),
      ],
    );
  }

  List _buildDayList(int count) {
    List<Widget> listItems = List();

    for (int i = 0; i < count; i++) {
      listItems.add(new Padding(
          padding: new EdgeInsets.all(20.0),
          child: new Text('Item ${i.toString()}',
              style: new TextStyle(fontSize: 25.0))));
    }

    return listItems;
  }
}
