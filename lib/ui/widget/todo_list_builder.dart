import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/ui/widget/new_todo_input_widget.dart';
import '../../main.dart';
import 'package:intl/intl.dart';
import '../../data/moor_database.dart';

class TodoListBuilder extends StatefulWidget {
  TodoListBuilder({Key key}) : super(key: key);

  @override
  _TodoListBuilderState createState() => _TodoListBuilderState();
}

class _TodoListBuilderState extends State<TodoListBuilder> {
  bool showCompleted = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _buildTaskList(context),
    );
  }

  StreamBuilder<List<Task>> _buildTaskList(BuildContext context) {
    final dao = Provider.of<TodoDao>(context);

    return StreamBuilder(
      stream: showCompleted ? dao.watchCompletedTasks() : dao.watchAllTasks(),
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
    return Dismissible(
      direction: DismissDirection.horizontal,
      key: Key(itemTask.id.toString()),
      onDismissed: (direction) {
        dao.deleteTask(itemTask);
      },
      background: Container(
        color: Colors.blue,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Icon(
              Icons.check,
              color: Colors.white,
              size: 32.0,
            ),
          ),
        ),
      ),
      secondaryBackground: Container(
        color: Colors.red,
        child: Align(
          alignment: Alignment.centerRight,
          child: Icon(
            Icons.delete,
            color: Colors.white,
            size: 32.0,
          ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          _buildCheckboxListTile(itemTask, dao),
          Divider(
            height: 8.0,
            color: Color.fromRGBO(150, 150, 150, 0.8),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckboxListTile(Task itemTask, TodoDao dao) {
    var addStrikeThough;
    if (itemTask.completed) {
      addStrikeThough = TextDecoration.lineThrough;
    }

    if (itemTask.dueDate != null) {
      return CheckboxListTile(
        title: Text(
          itemTask.name,
          style: TextStyle(
            decoration: addStrikeThough,
          ),
        ),
        subtitle: _addListTileSubtitle(itemTask, dao),
        value: itemTask.completed,
        controlAffinity: ListTileControlAffinity.leading,
        onChanged: (newValue) {
          dao.updateTask(itemTask.copyWith(completed: newValue));
          // dao.deleteTask(itemTask);
        },
      );
    } else {
      return CheckboxListTile(
        title: Text(
          itemTask.name,
          style: TextStyle(
            decoration: addStrikeThough,
          ),
        ),
        value: itemTask.completed,
        controlAffinity: ListTileControlAffinity.leading,
        onChanged: (newValue) {
          dao.updateTask(itemTask.copyWith(completed: newValue));
          // dao.deleteTask(itemTask);
        },
      );
    }
  }

  String _getFormatedDate(Task itemTask, TodoDao dao) {
    var dueDate = DateFormat.MMMd().add_E().format(itemTask.dueDate);
    return dueDate;
  }

  Widget _addListTileSubtitle(Task itemTask, TodoDao dao) {
    if (itemTask.completed) {
      return Text(
        _getFormatedDate(itemTask, dao),
        style: TextStyle(
          decoration: TextDecoration.lineThrough,
        ),
      );
    } else {
      return Text(
        _getFormatedDate(itemTask, dao),
      );
    }
  }
}
