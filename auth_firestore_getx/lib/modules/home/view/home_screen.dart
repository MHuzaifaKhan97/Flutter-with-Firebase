import 'package:auth_firestore_getx/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  final authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen',
            style: TextStyle(fontSize: 28, color: Colors.white)),
        centerTitle: true,
        toolbarHeight: MediaQuery.of(context).size.height * 0.15,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () => authController.logout(),
              icon: Icon(Icons.logout, color: Colors.white))
        ],
      ),
    );
  }
}
