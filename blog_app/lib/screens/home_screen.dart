import 'package:blog_app/screens/create_blog.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Blog',
              style: TextStyle(
                fontSize: 22,
              ),
            ),
            Text(
              'App',
              style: TextStyle(
                fontSize: 22,
                color: Colors.blue,
              ),
            )
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Container(),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (builder) => CreateBlog()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
