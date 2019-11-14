import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../main.dart';
import 'package:intl/intl.dart';
import '../../data/moor_database.dart';

class NewTodoInput extends StatefulWidget {
  NewTodoInput({Key key}) : super(key: key);

  @override
  _NewTodoInputState createState() => _NewTodoInputState();
}

class _NewTodoInputState extends State<NewTodoInput> {
  DateTime newTodoDate;
  TextEditingController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.white,
      foregroundColor: Colors.blue,
      onPressed: () {
        showModalBottomSheet(
          context: context,
          clipBehavior: Clip.antiAlias,
          builder: (context) => Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Container(
              height: 100.0,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  _buildTextField(context),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      _buildDateButton(context),
                      Text(
                        'Save',
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
      tooltip: 'Add a task',
      child: Icon(
        Icons.add,
        size: 40.0,
      ),
    );
  }

  TextField _buildTextField(BuildContext context) {
    return TextField(
      autofocus: true,
      controller: controller,
      decoration: InputDecoration(
        hintText: 'New to-do',
        hintStyle: TextStyle(
            fontWeight: FontWeight.bold, color: Color.fromRGBO(0, 0, 0, 0.4)),
        disabledBorder: InputBorder.none,
      ),
      onSubmitted: (inputName) {
        final database = Provider.of<AppDatabase>(context);
        final task = Task(
          name: inputName,
          dueDate: newTodoDate,
        );
        database.insertTask(task);
      },
    );
  }

  IconButton _buildDateButton(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.calendar_today),
      onPressed: () async {
        newTodoDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2015),
          lastDate: DateTime(2050),
        );
      },
    );
  }
}
