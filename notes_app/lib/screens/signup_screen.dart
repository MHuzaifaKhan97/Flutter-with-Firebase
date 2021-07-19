import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:notes_app/screens/home_screen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  var isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Sign up'.toUpperCase(),
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              buttonWidget(
                context,
                path: 'assets/google.svg',
                name: 'Continue with Google',
                size: 25,
              ),
              SizedBox(height: 15),
              buttonWidget(
                context,
                path: 'assets/phone.svg',
                name: 'Continue with Phone',
                size: 30,
                invert: true,
              ),
              SizedBox(height: 15),
              Text(
                'OR',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              SizedBox(height: 15),
              textItem(context,
                  labelText: 'Enter Email', controller: _emailController),
              SizedBox(height: 15),
              textItem(context,
                  labelText: 'Enter Password',
                  obscureText: true,
                  controller: _passwordController),
              SizedBox(height: 30),
              colorButton(),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an Account?',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Login',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget colorButton() {
    return InkWell(
      onTap: () async {
        this.setState(() {
          isLoading = true;
        });
        try {
          if (_emailController.text == "") {
            final emailSnackBar =
                SnackBar(content: Text('Please enter your email address'));
            ScaffoldMessenger.of(context).showSnackBar(emailSnackBar);
          } else if (_passwordController.text == "") {
            final passwordSnackBar =
                SnackBar(content: Text('Please enter your phone number'));
            ScaffoldMessenger.of(context).showSnackBar(passwordSnackBar);
          } else {
            UserCredential userCredential =
                await firebaseAuth.createUserWithEmailAndPassword(
                    email: _emailController.text.trim(),
                    password: _passwordController.text);
            print(userCredential);
            if (userCredential?.user?.email != null) {
              await showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  backgroundColor: Colors.black,
                  elevation: 10,
                  title: Text(
                    'Success',
                    style: TextStyle(color: Colors.green),
                  ),
                  content: Text('Successfully User Created',
                      style: TextStyle(color: Colors.white)),
                  actions: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                        ),
                        child: Text('Ok'))
                  ],
                ),
              );
              this.setState(() {
                isLoading = false;
              });
              _emailController.text = "";
              _passwordController.text = "";
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (builder) => HomeScreen()),
                  (route) => false);
            }
          }
        } catch (e) {
          final snackbar = SnackBar(content: Text(e?.message.toString()));
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
          this.setState(() {
            isLoading = false;
          });
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width - 90,
        height: 60,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(0xff000000),
            Color(0xff4a4747),
            Color(0xff000000),
            Color(0xff000000),
            Color(0xff4a4747),
            Color(0xff000000),
          ]),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: isLoading
              ? CircularProgressIndicator(
                  backgroundColor: Colors.white,
                )
              : Text(
                  "Sign Up".toUpperCase(),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
        ),
      ),
    );
  }

  Widget buttonWidget(BuildContext context,
      {String path, String name, double size, bool invert = false}) {
    return Container(
        width: MediaQuery.of(context).size.width - 80,
        height: 60,
        child: Card(
          color: invert ? Colors.white : Colors.black,
          elevation: 8,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: BorderSide(color: Colors.grey, width: 2)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                path,
                height: size,
                width: size,
              ),
              SizedBox(width: 8),
              Text(
                name,
                style: TextStyle(
                    color: invert ? Colors.black : Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ));
  }

  Widget textItem(BuildContext context,
      {String labelText,
      bool obscureText = false,
      TextEditingController controller}) {
    return Container(
      width: MediaQuery.of(context).size.width - 85,
      height: 55,
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(
            fontSize: 18,
            color: Colors.black,
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.grey, width: 2)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.grey, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.grey, width: 2)),
        ),
      ),
    );
  }
}
