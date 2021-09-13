import 'package:auth_firestore_getx/modules/home/view/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;

  Stream<User?> get streamAuthStatus => auth.authStateChanges();

  signup(String email, String password) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (userCredential.user != null) {
        Get.off(HomeScreen());
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('Weak password');
      } else if (e.code == 'email-already-in-use') {
        print('Email already exists');
      }
    }
  }

  login(String email, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found');
      } else if (e.code == 'wrong-password') {
        print('Username or password is incorrect');
      }
    }
  }

  void logout() async {
    await auth.signOut();
  }
}
