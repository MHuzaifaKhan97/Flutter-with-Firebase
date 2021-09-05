import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class AddTodoScreen extends StatelessWidget {
  final titleController = TextEditingController();
  final descController = TextEditingController();

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  addTodo(BuildContext context) async {
    if (titleController.text == "" || titleController.text == " ") {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.orange, content: Text('Please enter title')));
    } else if (descController.text == "" || descController.text == " ") {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.orange,
          content: Text('Please enter description')));
    } else {
      try {
        var id = generateRandomString(12);
        await firestore.collection('todos').doc(id).set({
          "id": id,
          "title": titleController.text,
          "desc": descController.text
        });

        titleController.text = "";
        descController.text = "";
        Navigator.pop(context);
      } catch (err) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Failed'),
                content: Text(err.toString()),
              );
            });
      }
    }
  }

  String generateRandomString(int len) {
    var r = Random();
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(len, (index) => _chars[r.nextInt(_chars.length)])
        .join();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[400],
        title: Text('Add Todo'),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Column(
            children: [
              SizedBox(height: 32),
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  hintText: "Enter Title",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Colors.orange,
                      style: BorderStyle.solid,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 32),
              TextField(
                controller: descController,
                decoration: InputDecoration(
                  hintText: "Enter Description",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Colors.orange,
                      style: BorderStyle.solid,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        // onPressed: () {},
        onPressed: () {
          addTodo(context);
        },
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}
