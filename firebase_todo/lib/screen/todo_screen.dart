import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_todo/screen/add_todo_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TodoScreen extends StatelessWidget {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final Stream<QuerySnapshot> _todoStream =
      FirebaseFirestore.instance.collection('todos').snapshots();

  Future<void> deleteTodo(String id, BuildContext context) async {
    print(id);
    await firestore.collection('todos').doc(id).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[400],
        title: Text('Todo App'),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddTodoScreen()));
              },
              child: Icon(
                Icons.add_box_outlined,
                color: Colors.white,
              ))
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: StreamBuilder<QuerySnapshot>(
            stream: _todoStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text('Something went wrong'));
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              return ListView(
                shrinkWrap: true,
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                  return Dismissible(
                      confirmDismiss: (DismissDirection direction) async {
                        var res = await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Confirm"),
                              content: const Text(
                                  "Are you sure you wish to delete this item?"),
                              actions: <Widget>[
                                ElevatedButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(true),
                                    child: const Text("DELETE")),
                                ElevatedButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(false),
                                  child: const Text("CANCEL"),
                                ),
                              ],
                            );
                          },
                        );
                        print(res);
                        if (res) {
                          deleteTodo(data['id'], context);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.orange,
                              content: Text('${data['title']} Deleted')));
                        }
                      },
                      background: Container(
                        color: Colors.red,
                      ),
                      key: ValueKey(data['id']),
                      child: Card(
                          elevation: 3,
                          child: singleTodo(data['title'], data['desc'])));
                }).toList(),
              );
            },
          ),
        ),
      ),
    );
  }

  ListTile singleTodo(String title, String desc) {
    return ListTile(
      title: Text(title),
      subtitle: Text(desc),
    );
  }
}
