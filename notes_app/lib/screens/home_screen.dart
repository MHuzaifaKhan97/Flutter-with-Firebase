import 'package:flutter/material.dart';
import 'package:notes_app/screens/signin_screen.dart';
import 'package:notes_app/services/auth_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AuthClass _authClass = AuthClass();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes App'),
        actions: [
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () async {
                await _authClass.logout();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (builder) => SignInScreen()),
                    (route) => false);
              })
        ],
      ),
    );
  }
}
