import 'package:flutter/material.dart';

class PostWidget extends StatelessWidget {
  String title;
  String desc;
  String url;
  PostWidget({this.title = "", this.desc = "", this.url = ""});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              url,
            ),
            SizedBox(height: 6),
            Text(
              title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 6),
            Text(desc)
          ],
        ),
      ),
    );
  }
}
