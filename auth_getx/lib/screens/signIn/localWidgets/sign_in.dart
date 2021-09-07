import 'package:auth_getx/config.dart';
import 'package:flutter/material.dart';

class SignIn extends StatelessWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // show header title
        Expanded(
            flex: 2,
            child: Column(
              children: [
                Text(
                  'Welcome!',
                  style: TextStyle(
                      fontSize: Config.screenWidth! * 0.1,
                      color: kPrimaryColor),
                ),
                Text(
                  'Enter email and password to login...',
                  style: TextStyle(
                    fontSize: Config.screenWidth! * 0.04,
                  ),
                )
              ],
            )),
        // show hero image
        Expanded(flex: 4, child: Container()),
        // show textfields and buttons
        Expanded(flex: 5, child: Container()),
      ],
    );
  }
}
