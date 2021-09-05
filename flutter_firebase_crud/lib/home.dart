import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_crud/post.dart';
import 'package:flutter_firebase_crud/signin.dart';

class HomeScreen extends StatefulWidget {
  String? uid = "";
  HomeScreen(this.uid);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  String userName = "";
  Stream<QuerySnapshot> postStream =
      FirebaseFirestore.instance.collection('posts').snapshots();
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  logout() async {
    await auth.signOut();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<DocumentSnapshot>(
          future: users.doc(widget.uid).get(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              Map<String, dynamic> data =
                  snapshot.data!.data() as Map<String, dynamic>;
              return Text(
                "Welcome ${data["username"].toString().split(' ')[0]}",
                style: TextStyle(fontSize: 19),
              );
            }

            return CircularProgressIndicator();
          },
        ),
        // title: Text(
        //   'Welcome',
        //   // "Welcome ${data["username"].toString().split(' ')[0]}",
        //   style: TextStyle(fontSize: 19),
        // ),
        actions: [ElevatedButton(onPressed: logout, child: Text('Logout'))],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
        child: SafeArea(
            child: StreamBuilder<QuerySnapshot>(
          stream: postStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Scaffold(
                  body: Center(child: Text('Something went wrong')));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }

            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                return PostWidget(
                  title: data['title'],
                  desc: data['description'],
                  url: data['url'],
                );
              }).toList(),
            );
          },
        )),
      ),
    );
  }
}
