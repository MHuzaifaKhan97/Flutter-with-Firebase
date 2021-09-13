import 'package:auth_firestore_getx/controllers/auth_controller.dart';
import 'package:auth_firestore_getx/modules/login/controller/login_controller.dart';
import 'package:auth_firestore_getx/modules/signup/view/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  final authController = Get.find<AuthController>();
  final loginController = Get.put(LoginController(), permanent: true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Screen',
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
                controller: loginController.emailController,
                decoration: InputDecoration(labelText: 'Enter Email'),
              ),
              SizedBox(height: 16),
              TextField(
                controller: loginController.passwordController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Enter Password'),
              ),
              SizedBox(height: 32),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(45),
                    primary: Colors.orange[400]),
                onPressed: () async {
                  await authController.login(
                      loginController.emailController.text,
                      loginController.passwordController.text);
                },
                child: Text(
                  'Login',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Don\'t have account?'),
                  SizedBox(width: 2),
                  GestureDetector(
                    onTap: () => Get.off(SignUpScreen()),
                    child: Text(
                      'Register',
                      style: TextStyle(color: Colors.orange[400]),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
