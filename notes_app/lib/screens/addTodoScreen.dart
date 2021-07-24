import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddTodoScreen extends StatefulWidget {
  @override
  _AddTodoScreenState createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30),
              IconButton(
                  icon: Icon(
                    CupertinoIcons.arrow_left,
                    color: Color(0xff1d1d1d),
                    size: 28,
                  ),
                  onPressed: () {}),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Create',
                      style: TextStyle(
                          fontSize: 33,
                          color: Color(0xff1d1d1d),
                          fontWeight: FontWeight.bold,
                          letterSpacing: 3),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'New Note',
                      style: TextStyle(
                          fontSize: 33,
                          color: Color(0xff1d1d1d),
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2),
                    ),
                    SizedBox(height: 24),
                    label("Task Title"),
                    SizedBox(height: 12),
                    title(),
                    SizedBox(height: 24),
                    label("Task Type"),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        chipData("Important", 0xff2664fa),
                        SizedBox(width: 12),
                        chipData("Planned", 0xff2bc8d9),
                      ],
                    ),
                    SizedBox(height: 24),
                    label("Description"),
                    SizedBox(height: 12),
                    description(),
                    SizedBox(height: 24),
                    label("Category"),
                    SizedBox(height: 12),
                    Wrap(
                      runSpacing: 10,
                      children: [
                        chipData("Food", 0xffff6d6e),
                        SizedBox(width: 12),
                        chipData("Study", 0xfff29732),
                        SizedBox(width: 12),
                        chipData("Work", 0xfff6657ff),
                        SizedBox(width: 12),
                        chipData("Design", 0xfff234ebd),
                        SizedBox(width: 12),
                        chipData("Run", 0xff2bc8d9),
                      ],
                    ),
                    SizedBox(height: 50),
                    button(),
                    SizedBox(height: 30),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget button() {
    return Container(
      height: 55,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xff8a32f1),
            Color(0xffad32f9),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Text(
          'Add Note',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18),
        ),
      ),
    );
  }

  Widget description() {
    return Container(
      height: 150,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        style: TextStyle(
          color: Colors.grey,
          fontSize: 17,
        ),
        maxLines: null,
        decoration: InputDecoration(
          hintText: 'Task Description',
          border: InputBorder.none,
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 17,
          ),
          contentPadding: EdgeInsets.only(left: 20, right: 20),
        ),
      ),
    );
  }

  Widget chipData(String label, int color) {
    return Chip(
        backgroundColor: Color(color),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        labelPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        label: Text(
          label,
          style: TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
        ));
  }

  Widget title() {
    return Container(
      height: 55,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        style: TextStyle(
          color: Colors.grey,
          fontSize: 17,
        ),
        decoration: InputDecoration(
          hintText: 'Task Title',
          border: InputBorder.none,
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 17,
          ),
          contentPadding: EdgeInsets.only(left: 20, right: 20),
        ),
      ),
    );
  }

  Widget label(String label) {
    return Text(
      label,
      style: TextStyle(
          color: Color(0xff1d1d1d),
          fontSize: 18,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.2),
    );
  }
}
