import 'package:auth_getx/config.dart';
import 'package:flutter/material.dart';

class Root extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Container();
  }
}
