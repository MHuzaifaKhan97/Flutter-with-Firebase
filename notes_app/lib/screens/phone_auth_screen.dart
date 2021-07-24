import 'dart:async';

import 'package:flutter/material.dart';
import 'package:notes_app/services/auth_service.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:flutter/services.dart';

class PhoneAuthScreen extends StatefulWidget {
  @override
  _PhoneAuthScreenState createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  int start = 30;
  bool wait = false;
  String buttonName = "Send";
  TextEditingController phoneController = TextEditingController();
  String verificationIDFinal = "";
  String smsCode = "";
  AuthClass _authClass = AuthClass();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Sign Up With Phone'.toUpperCase(),
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        toolbarHeight: 80,
        shadowColor: Colors.orangeAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 80),
              textField(),
              SizedBox(height: 30),
              Container(
                width: MediaQuery.of(context).size.width - 34,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 1,
                        color: Colors.grey,
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Text('Enter 6 Digits OTP')),
                    Expanded(
                      child: Container(
                        height: 1,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              otpField(),
              SizedBox(height: 30),
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                  text: "Send OTP again in",
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                TextSpan(
                  text: " 00:$start",
                  style: TextStyle(fontSize: 16, color: Colors.red),
                ),
                TextSpan(
                  text: " sec",
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ])),
              SizedBox(height: 80),
              InkWell(
                onTap: () async {
                  await _authClass.signInWithPhoneNumber(
                      verificationIDFinal, smsCode, context);
                },
                child: Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width - 60,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(width: 2, color: Color(0xff1d1d1d))),
                  child: Center(
                    child: Text(
                      "Next".toUpperCase(),
                      style: TextStyle(
                        color: Color(0xff1d1d1d),
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void startTime() {
    const onsec = Duration(seconds: 1);
    Timer timer = Timer.periodic(onsec, (timer) {
      if (start == 0) {
        setState(() {
          timer.cancel();
          wait = false;
        });
      } else {
        setState(() {
          start--;
        });
      }
    });
  }

  Widget otpField() {
    return OTPTextField(
      length: 6,
      width: MediaQuery.of(context).size.width - 40,
      fieldWidth: 42,
      otpFieldStyle: OtpFieldStyle(
        backgroundColor: Color(0xff1d1d1d),
        borderColor: Colors.black,
      ),
      style: TextStyle(fontSize: 17, color: Colors.white),
      fieldStyle: FieldStyle.underline,
      onCompleted: (pin) {
        print("Completed: " + pin);
        setState(() {
          smsCode = pin;
        });
      },
    );
  }

  Widget textField() {
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width - 40,
      height: 60,
      decoration: BoxDecoration(
        color: Color(0xff1d1d1d),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: TextFormField(
          controller: phoneController,
          keyboardType: TextInputType.number,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Enter your phone number",
            hintStyle: TextStyle(color: Colors.white54, fontSize: 17),
            prefixIcon: Padding(
              padding: EdgeInsets.symmetric(vertical: 11, horizontal: 15),
              child: Text(
                " (+92) ",
                style: TextStyle(color: Colors.white, fontSize: 17),
              ),
            ),
            suffixIcon: InkWell(
              onTap: wait
                  ? null
                  : () async {
                      startTime();
                      setState(() {
                        start = 30;
                        wait = true;
                        buttonName = "Resend";
                      });
                      await _authClass.verifyPhoneNumber(
                          "+92 ${phoneController.text}", context, setData);
                    },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 13, horizontal: 15),
                child: Text(
                  buttonName,
                  style: TextStyle(
                      color: wait ? Colors.grey : Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void setData(String verificationID) {
    setState(() {
      verificationIDFinal = verificationID;
    });
    startTime();
  }
}
