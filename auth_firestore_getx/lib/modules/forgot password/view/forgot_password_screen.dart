import 'package:auth_firestore_getx/controllers/auth_controller.dart';
import 'package:auth_firestore_getx/modules/forgot%20password/controller/forgot_password_controller.dart';
import 'package:auth_firestore_getx/modules/login/controller/login_controller.dart';
import 'package:auth_firestore_getx/modules/login/view/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final authController = Get.find<AuthController>();
  final forgotPasswordController =
      Get.put(ForgotPasswordController(), permanent: true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password',
            style: TextStyle(fontSize: 28, color: Colors.white)),
        centerTitle: true,
        toolbarHeight: MediaQuery.of(context).size.height * 0.15,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.12),
              TextField(
                controller: forgotPasswordController.emailController,
                decoration: InputDecoration(labelText: 'Enter Email'),
              ),
              SizedBox(height: 32),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(45),
                    primary: Colors.orange[400]),
                onPressed: () async {
                  await authController.forgotPassword(
                      forgotPasswordController.emailController.text);
                },
                child: Text(
                  'Forgot Password',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(height: 16),
              GestureDetector(
                onTap: () => Get.off(LoginScreen()),
                child: Text(
                  'Back to Login',
                  style: TextStyle(color: Colors.orange[400]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
