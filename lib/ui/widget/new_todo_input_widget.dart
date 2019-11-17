import 'package:flutter/material.dart';
import 'package:moor_flutter/moor_flutter.dart' hide Column;
import 'package:provider/provider.dart';
import '../../data/moor_database.dart';

class NewTodoInput extends StatefulWidget {
  NewTodoInput({Key key}) : super(key: key);

  @override
  _NewTodoInputState createState() => _NewTodoInputState();
}

class _NewTodoInputState extends State<NewTodoInput> {
  DateTime newTodoDate;
  TextEditingController todoInputController;
  String inputValue;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    todoInputController = TextEditingController();
    inputValue = todoInputController.text;
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.white,
      foregroundColor: Colors.blue,
      onPressed: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          clipBehavior: Clip.antiAlias,
          builder: (context) => AnimatedPadding(
            padding: EdgeInsets.only(
              bottom: (MediaQuery.of(context).viewInsets.bottom),
            ),
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOutCirc,
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
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: _buildDateButton(context),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: _buildDetailsButton(context),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          var input = inputValue;
                          print(input);
                          insertNewTodo(input);

                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: Container(
                            child: Text(
                              'Save',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
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
      controller: todoInputController,
      decoration: InputDecoration(
        hintText: 'New to-do',
        hintStyle: TextStyle(
            fontWeight: FontWeight.bold, color: Color.fromRGBO(0, 0, 0, 0.4)),
        disabledBorder: InputBorder.none,
      ),
      onChanged: (String input) {
        inputValue = todoInputController.text;
      },
      onSubmitted: (input) {
        print(input);
        insertNewTodo(input);
        Navigator.pop(context);
      },
    );
  }

  Future insertNewTodo(String input) {
    final dao = Provider.of<TodoDao>(context);
    final task = TasksCompanion(
      name: Value(input),
      dueDate: Value(newTodoDate),
    );
    todoInputController.text = '';
    return dao.insertTask(task);
  }

  IconButton _buildDetailsButton(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.mode_comment),
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
