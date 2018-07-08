import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'YATODO',
        theme: new ThemeData(
        primarySwatch: Colors.black,
      ),
      home: new TodoList(),
    );
  }
}

class TodoList extends StatefulWidget {

  @override
  _TodoListState createState() => new _TodoListState();
}

class _TodoListState extends State<TodoList> {
  int _listItems = [];


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Yet Another Todo List'),
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.list), onPressed: _deleteAllItems)
        ],
      ),
      body: _buildTodoList(),
      floatingActionButton: FloatingActionButton(
          onPressed: _addItem,
          tooltip: 'new Item',
          child: Icon(Icons.add),
                                                )
    );
  }

  Widget _buildTodoList() {
    // code for the todolist layout (use list builder)
  }

  void _deleteAllItems() {
    // code to remove all todo items and clear the screen
    // attached to 'x' icon on appbar
  }

  void _deleteItem() {
    // deletes a single item in todo list
    // activated by long press on the item in list
  }

  void _newItem() {
    // insert navigator to open the page to add new item
  }
}
