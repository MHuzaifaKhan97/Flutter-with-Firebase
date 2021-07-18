import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
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
                'Sign In'.toUpperCase(),
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
              textItem(context, labelText: 'Enter Email'),
              SizedBox(height: 15),
              textItem(context, labelText: 'Enter Password'),
              SizedBox(height: 30),
              colorButton(),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t have an Account?',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(width: 8),
                  Text(
                    'SignUp',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              SizedBox(height: 15),
              Text(
                'Forgot Password?',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget colorButton() {
    return Container(
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
        child: Text(
          "Sign In".toUpperCase(),
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
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

  Widget textItem(BuildContext context, {String labelText}) {
    return Container(
      width: MediaQuery.of(context).size.width - 85,
      height: 55,
      child: TextFormField(
        decoration: InputDecoration(
            labelText: labelText,
            labelStyle: TextStyle(
              fontSize: 18,
              color: Colors.black,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.grey, width: 2),
            )),
      ),
    );
  }
}
