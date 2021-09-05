import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_crud/home.dart';
import 'package:flutter_firebase_crud/signup.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;

  void signInUser() async {
    final String email = _emailController.text;
    final String password = _passwordController.text;

    try {
      final UserCredential user = await auth.signInWithEmailAndPassword(
          email: email, password: password);

      _emailController.text = "";
      _passwordController.text = "";
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => HomeScreen(user.user?.uid)));
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 64),
                Text(
                  'Sign In',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 48),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Enter your email'),
                ),
                SizedBox(height: 12),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Enter your password'),
                ),
                SizedBox(height: 40),
                ElevatedButton(
                  onPressed: signInUser,
                  child: Text('Login'),
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size.fromHeight(45)),
                ),
                SizedBox(height: 8),
                Text('Or'),
                SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterScreen()));
                  },
                  child: Text('Register'),
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size.fromHeight(45)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
