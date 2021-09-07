import 'package:auth_getx/config.dart';
import 'package:auth_getx/screens/signIn/localWidgets/sign_in.dart';
import 'package:flutter/material.dart';

class Root extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Scaffold(
      body: SafeArea(
        child: SignIn(),
      ),
    );
  }
}
