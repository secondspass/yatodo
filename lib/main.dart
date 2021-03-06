import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  List<String> _listItems = <String>[];
  List<String> _completed = <String>[];

  @override
  void initState() {
    super.initState();
    _loadTodoList();
  }

  void _loadTodoList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _listItems = (prefs.getStringList('todolist') ?? <String>[]);
      _completed = (prefs.getStringList('completed') ?? <String>[]);
    });
  }

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
            _syncToDisk();
          },
        );
      },
      onLongPress: _deleteItem(item, alreadyDone),
    );
  }

  void _deleteAllItems() {
    setState(() {
      _listItems.clear();
      _completed.clear();
      _syncToDisk();
    });
  }

  void _syncToDisk() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('todolist', _listItems);
    prefs.setStringList('completed', _completed);
  }

  void _deleteItem(String item, bool alreadyDone) {
    // deletes a single item in todo list
    // activated by long press on the item in list
    // returns an anonymous function with item in closure
    return () {
      setState(() {
        _listItems.remove(item);
        if (alreadyDone) {
          _completed.remove(item);
        }
        _syncToDisk();
      });
    };
  }

  void _addNewItem() {
    // insert navigator to open the page to add new item
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context) {
          final itemEntryField =
              new TextField(controller: new TextEditingController());
          final addButton = new RaisedButton(
              child: Text('ADD ITEM'),
              onPressed: () {
                setState(() {
                  String itemText = itemEntryField.controller.text;
                  if ((itemText != '') || !_listItems.contains(itemText)) {
                    _listItems.add(itemText);
                    itemEntryField.controller.text = '';
                    _syncToDisk();
                  }
                });
              });

          return new Scaffold(
            appBar: new AppBar(
              title: new Text('Add new item'),
            ),
            body: new Column(children: <Widget>[
              itemEntryField,
              addButton,
              new Text('Press back button to go back to list')
            ]),
          );
        },
      ),
    );
  }
}
