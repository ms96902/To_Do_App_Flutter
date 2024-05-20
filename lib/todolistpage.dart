import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/authenticateScreen.dart';

class TodoListPage extends StatefulWidget {
  @override
  _TodoListPageState createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final TextEditingController _titleController = TextEditingController();
  DateTime? _selectedDate;
  bool _isCompleted = false;
  List<ParseObject> _tasks = [];

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  void _loadTasks() async {
    var query = QueryBuilder<ParseObject>(ParseObject('Todo'))
      ..whereEqualTo('user', await ParseUser.currentUser());
    var response = await query.query();

    if (response.success && response.results != null) {
      setState(() {
        _tasks = response.results!.cast<ParseObject>();
      });
    }
  }

  void _addTask() async {
    if (_titleController.text.trim().isEmpty || _selectedDate == null) {
      return;
    }
    var currentUser = await ParseUser.currentUser();
    var task = ParseObject('Todo')
      ..set('title', _titleController.text.trim())
      ..set('dueDate', _selectedDate!.toIso8601String())
      ..set('isCompleted', _isCompleted)
      ..set('user', currentUser);
    await task.save();

    _titleController.clear();
    _selectedDate = null;
    _isCompleted = false;
    _loadTasks();
  }

  void _updateTask(ParseObject task) async {
    task
      ..set('title', _titleController.text.trim())
      ..set('dueDate', _selectedDate!.toIso8601String())
      ..set('isCompleted', _isCompleted);
    await task.save();
    _titleController.clear();
    _selectedDate = null;
    _isCompleted = false;
    _loadTasks();
  }

  void _deleteTask(ParseObject task) async {
    await task.delete();
    _loadTasks();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
      });
  }

  void _toggleTaskStatus(ParseObject task) async {
    task.set('isCompleted', !task.get<bool>('isCompleted')!);
    await task.save();
    _loadTasks();
  }

  void _showTaskDialog({ParseObject? task}) {
    if (task != null) {
      _titleController.text = task.get<String>('title') ?? '';
      _selectedDate = DateTime.parse(task.get<String>('dueDate')!);
      _isCompleted = task.get<bool>('isCompleted')!;
    } else {
      _titleController.clear();
      _selectedDate = null;
      _isCompleted = false;
    }

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              title: Text(
                task == null ? 'Add Task' : 'Update Task',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      labelText: 'Task Title',
                      labelStyle: TextStyle(fontFamily: 'Roboto'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          _selectedDate == null
                              ? 'No date chosen!'
                              : 'Due Date: ${DateFormat.yMd().format(_selectedDate!)}',
                          style: TextStyle(fontFamily: 'Roboto'),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => _selectDate(context),
                        child: Text('Choose Date'),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        'Completed:',
                        style: TextStyle(fontFamily: 'Roboto'),
                      ),
                      Checkbox(
                        value: _isCompleted,
                        onChanged: (bool? value) {
                          setState(() {
                            _isCompleted = value!;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    if (task == null) {
                      _addTask();
                    } else {
                      _updateTask(task);
                    }
                  },
                  child: Text(task == null ? 'Add' : 'Update'),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your To-Do List!',
          style: TextStyle(
            fontSize: 32,
            fontFamily: 'PoetsenOne',
            color: Color(0xFF3D52A0),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await ParseUser.currentUser().then((user) => user.logout());
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => AuthenticationScreen()),
              );
            },
          ),
        ],
        backgroundColor: Color(0xFFADBBDA),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFADBBDA), Color(0xFFEDE8F5)],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () => _showTaskDialog(),
                child: Text(
                  'Add Task',
                  style: TextStyle(
                    fontSize: 25,
                    fontFamily: 'PoetsenOne',
                    color: Color(0xFF3D52A0),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                child: _tasks.isEmpty
                    ? Center(
                        child: Text(
                          'No tasks available',
                          style: TextStyle(
                              fontSize: 25,
                              fontFamily: 'Roboto',
                              color: Color(0xFF3D52A0)),
                        ),
                      )
                    : ListView.builder(
                        itemCount: _tasks.length,
                        itemBuilder: (context, index) {
                          final task = _tasks[index];
                          final taskTitle =
                              task.get<String>('title') ?? 'No Title';
                          final dueDateStr = task.get<String>('dueDate');
                          final dueDate = dueDateStr != null
                              ? DateFormat.yMd()
                                  .format(DateTime.parse(dueDateStr))
                              : 'No Due Date';
                          final isCompleted =
                              task.get<bool>('isCompleted') ?? false;

                          return Card(
                            margin: EdgeInsets.symmetric(vertical: 8.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: ListTile(
                              title: Text(
                                taskTitle,
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                'Due Date: $dueDate',
                                style: TextStyle(fontFamily: 'Roboto'),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Checkbox(
                                    value: isCompleted,
                                    onChanged: (value) =>
                                        _toggleTaskStatus(task),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.edit),
                                    onPressed: () =>
                                        _showTaskDialog(task: task),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.delete),
                                    onPressed: () => _deleteTask(task),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
