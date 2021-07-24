import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:notes_app/screens/addTodoScreen.dart';
import 'package:notes_app/screens/home_screen.dart';
import 'package:notes_app/screens/signin_screen.dart';
import 'package:notes_app/screens/signup_screen.dart';
import 'package:notes_app/services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget currentPage = SignInScreen();
  AuthClass _authClass = AuthClass();
  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  void checkLogin() async {
    String token = await _authClass.getToken();
    if (token != null) {
      setState(() {
        currentPage = HomeScreen();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
