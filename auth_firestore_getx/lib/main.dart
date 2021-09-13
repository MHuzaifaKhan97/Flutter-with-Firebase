import 'package:auth_firestore_getx/controllers/auth_controller.dart';
import 'package:auth_firestore_getx/modules/home/view/home_screen.dart';
import 'package:auth_firestore_getx/modules/login/view/login_screen.dart';
import 'package:auth_firestore_getx/widgets/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final authC = Get.put(AuthController(), permanent: true);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: authC.streamAuthStatus,
      builder: (context, snapshot) {
        print(snapshot.data);
        if (snapshot.connectionState == ConnectionState.active) {
          return GetMaterialApp(
            title: 'Auth Firestore with Getx',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(primaryColor: Colors.orange[400]),
            home: snapshot.data != null ? HomeScreen() : LoginScreen(),
          );
        }
        return LoadingWidget();
      },
    );
  }
}
