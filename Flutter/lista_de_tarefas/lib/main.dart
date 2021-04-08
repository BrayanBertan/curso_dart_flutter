import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(ListaDeTarefasApp());
}

class ListaDeTarefasApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.amber),
      home: ListaDeTarefasPage(),
    );
  }
}

class ListaDeTarefasPage extends StatefulWidget {
  @override
  _ListaDeTarefasPageState createState() => _ListaDeTarefasPageState();
}

class _ListaDeTarefasPageState extends State<ListaDeTarefasPage> {
  List _todoList = [];
  Map<String, dynamic> _lastRemoved;
  int _lastRemovedPos;
  final tarefaController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _readData().then((value) {
      setState(() {
        _todoList = json.decode(value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Lista de tarefas",
          style: TextStyle(color: Colors.white, fontSize: 28.0),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                    child: TextField(
                  controller: tarefaController,
                  decoration: InputDecoration(
                      labelText: "Nova tarefa", border: OutlineInputBorder()),
                )),
                SizedBox(
                  width: 5.0,
                ),
                RaisedButton(
                    color: Colors.amber,
                    child: Text("ADD"),
                    onPressed: () {
                      setState(() {
                        _todoList
                            .add({"title": tarefaController.text, "ok": false});
                        tarefaController.text = "";
                        _saveData();
                      });
                    })
              ],
            ),
          ),
          Expanded(
              child: RefreshIndicator(
            child: ListView.builder(
                padding: EdgeInsets.all(12.0),
                itemCount: _todoList.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: ValueKey(
                        DateTime.now().millisecondsSinceEpoch.toString()),
                    background: Container(
                      color: Colors.red,
                      child: Align(
                        alignment: Alignment(-0.9, 0.0),
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    direction: DismissDirection.startToEnd,
                    child: CheckboxListTile(
                      title: Text(_todoList[index]["title"]),
                      secondary: CircleAvatar(
                        child: Icon(
                            _todoList[index]["ok"] ? Icons.check : Icons.error),
                      ),
                      value: _todoList[index]["ok"],
                      onChanged: (value) {
                        setState(() {
                          _todoList[index]["ok"] = value;
                          _saveData();
                        });
                      },
                    ),
                    onDismissed: (direction) {
                      setState(() {
                        _lastRemoved = Map.from(_todoList[index]);
                        _lastRemovedPos = index;
                        _todoList.removeAt(index);
                        _saveData();

                        final snack = SnackBar(
                          content:
                              Text("Tarefa ${_lastRemoved["title"]} removida!"),
                          action: SnackBarAction(
                              label: "Desfazer",
                              onPressed: () {
                                setState(() {
                                  _todoList.insert(
                                      _lastRemovedPos, _lastRemoved);
                                });
                              }),
                          duration: Duration(seconds: 2),
                        );
                        Scaffold.of(context).removeCurrentSnackBar();
                        Scaffold.of(context).showSnackBar(snack);
                      });
                    },
                  );
                }),
            onRefresh: () async {
              await Future.delayed(Duration(seconds: 1));
              setState(() {
                _todoList.sort((a, b) {
                  if (a["ok"] && !b["ok"])
                    return 1;
                  else if (!a["ok"] && b["ok"])
                    return -1;
                  else
                    return 0;
                });
                _saveData();
              });
            },
          ))
        ],
      ),
    );
  }

  Future<File> _getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File("${directory.path}/datarefa.json");
  }

  Future<File> _saveData() async {
    String data = json.encode(_todoList);
    final file = await _getFile();
    return file.writeAsString(data);
  }

  Future<String> _readData() async {
    try {
      final file = await _getFile();
      return file.readAsString();
    } catch (e) {
      return null;
    }
  }
}
