import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/ui/widget/new_todo_input_widget.dart';
import '../../main.dart';
import 'package:intl/intl.dart';
import '../../data/moor_database.dart';

class DoneTodoListBuilder extends StatefulWidget {
  DoneTodoListBuilder({Key key}) : super(key: key);

  @override
  _DoneTodoListBuilderState createState() => _DoneTodoListBuilderState();
}

class _DoneTodoListBuilderState extends State<DoneTodoListBuilder> {
  bool showCompleted = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _buildDoneTaskList(context),
    );
  }

  StreamBuilder<List<Task>> _buildDoneTaskList(BuildContext context) {
    final dao = Provider.of<TodoDao>(context);

    return StreamBuilder(
      stream: dao.watchCompletedTasks(),
      builder: (context, AsyncSnapshot<List<Task>> snapshot) {
        final tasks = snapshot.data ?? List();

        return ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (_, index) {
            final itemTask = tasks[index];
            return _buildListItem(itemTask, dao);
          },
        );
      },
    );
  }

  Widget _buildListItem(Task itemTask, TodoDao dao) {
    return ListTile(
      key: Key(itemTask.id.toString()),
      leading: Icon(Icons.done, color: Colors.blueAccent),
      title: Text(
        itemTask.name,
        style: TextStyle(
          decoration: TextDecoration.lineThrough,
        ),
      ),
    );
  }
}
