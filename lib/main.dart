import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'YATODO',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
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
  final _listItems = <String>['item1', 'item2', 'item3'];
  final _completed = <String>[];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Yet Another Todo List'),
          actions: <Widget>[
            new IconButton(
                icon: new Icon(Icons.delete_sweep), onPressed: _deleteAllItems)
          ],
        ),
        body: _buildTodoList(),
        floatingActionButton: FloatingActionButton(
          onPressed: _addNewItem,
          tooltip: 'new Item',
          child: Icon(Icons.add),
        ));
  }

  Widget _buildTodoList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        if (i < _listItems.length) {
          return _buildRow(_listItems[i]);
        }
      },
    );
  }

  Widget _buildRow(String item) {
    final alreadyDone = _completed.contains(item);
    return new ListTile(
      title: new Text(
        item,
      ),
      leading: new Icon(
        alreadyDone ? Icons.check_circle : Icons.check_circle_outline,
        color: alreadyDone ? Colors.green : null,
      ),
      onTap: () {
        setState(
          () {
            if (alreadyDone) {
              _completed.remove(item);
            } else {
              _completed.add(item);
            }
          },
        );
      },
    );
  }

  void _deleteAllItems() {
    // code to remove all todo items and clear the screen
    // attached to 'x' icon on appbar
  }

  void _deleteItem() {
    // deletes a single item in todo list
    // activated by long press on the item in list
  }

  void _addNewItem() {
    // insert navigator to open the page to add new item
  }
}
