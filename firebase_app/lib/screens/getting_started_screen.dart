import 'dart:async';

import 'package:firebase_app/screens/login_screen.dart';
import 'package:firebase_app/widgets/btn_widget.dart';
import 'package:flutter/material.dart';

class GettingStartedScreen extends StatefulWidget {
  @override
  _GettingStartedScreenState createState() => _GettingStartedScreenState();
}

class _GettingStartedScreenState extends State<GettingStartedScreen> {
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   Timer(const Duration(milliseconds: 4000), () {
  //     Navigator.push(
  //         context, MaterialPageRoute(builder: (context) => LoginScreen()));
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Color(0xffF5591F), Color(0xfffca54e)],
              end: Alignment.bottomCenter,
              begin: Alignment.topCenter),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Notes App',
                    style: TextStyle(fontSize: 50, color: Colors.white),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 3,
                            style: BorderStyle.solid,
                            color: Colors.white),
                        borderRadius: BorderRadius.circular(100)),
                    child: Image.asset(
                      "assets/todo2.png",
                      scale: 5,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
              ),
              ButtonWidget(
                btnText: 'GET STARTED',
                color: Colors.white,
                onClick: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.005,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
