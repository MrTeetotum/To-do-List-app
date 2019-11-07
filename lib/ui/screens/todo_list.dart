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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: CustomScrollView(
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
                              child: Text('data'),
                            ));
                      }))),
          SliverAppBar(
            titleSpacing: 50.0,
            expandedHeight: 100.0,
            flexibleSpace: const FlexibleSpaceBar(
              titlePadding: EdgeInsetsDirectional.only(start: 16, bottom: 32),
              title: Text(
                "To-do list",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              centerTitle: false,
            ),
            floating: false,
            pinned: false,
            snap: false,
            brightness: Brightness.light,
            backgroundColor: Colors.transparent,
          ),
          new SliverList(
            delegate: new SliverChildListDelegate(_buildList(50)),
          ),
        ],
      ),
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
            )),
        elevation: 20.0,
        shape: CircularNotchedRectangle(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        foregroundColor: Colors.blue,
        onPressed: _incrementCounter,
        tooltip: 'Add a task',
        child: Icon(
          Icons.add,
          size: 40.0,
        ),
      ),
    );
  }

  List _buildList(int count) {
    List<Widget> listItems = List();

    for (int i = 0; i < count; i++) {
      listItems.add(new Padding(
          padding: new EdgeInsets.all(20.0),
          child: new Text('Item ${i.toString()}',
              style: new TextStyle(fontSize: 25.0))));
    }

    return listItems;
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
