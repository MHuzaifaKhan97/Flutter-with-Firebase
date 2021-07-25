import 'package:flutter/material.dart';

class CreateBlog extends StatefulWidget {
  @override
  _CreateBlogState createState() => _CreateBlogState();
}

class _CreateBlogState extends State<CreateBlog> {
  String authorName, title, description;

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
        actions: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Icon(Icons.file_upload),
          )
        ],
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 10),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              height: 150,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
              ),
              width: MediaQuery.of(context).size.width,
              child: Icon(
                Icons.add_a_photo,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            Container(
              margin: EdgeInsets.all(16),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Author name',
                    ),
                    onChanged: (val) {
                      authorName = val;
                    },
                  ),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Title',
                    ),
                    onChanged: (val) {
                      title = val;
                    },
                  ),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Description',
                    ),
                    onChanged: (val) {
                      description = val;
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
