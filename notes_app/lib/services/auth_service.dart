import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:notes_app/screens/home_screen.dart';

class AuthClass {
  GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: ['email', 'https://www.googleapis.com/auth/contacts.readonly']);

  FirebaseAuth auth = FirebaseAuth.instance;
  final storage = FlutterSecureStorage();

  Future<void> googleSignIn(BuildContext context) async {
    try {
      GoogleSignInAccount _googleSignInAccount = await _googleSignIn.signIn();
      if (_googleSignIn != null) {
        GoogleSignInAuthentication googleSignInAuthentication =
            await _googleSignInAccount.authentication;

        AuthCredential credential = GoogleAuthProvider.credential(
            idToken: googleSignInAuthentication.idToken,
            accessToken: googleSignInAuthentication.accessToken);

        // Like we previously did signInWithEmailAndPassword()
        try {
          UserCredential userCredential =
              await auth.signInWithCredential(credential);

          storeTokenAndData(userCredential);

          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (builder) => HomeScreen()),
              (route) => false);
        } catch (e) {
          final snackBar = SnackBar(content: Text(e?.message.toString()));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      } else {
        final snackBar = SnackBar(content: Text("Unable to Sign In"));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } catch (e) {
      final snackBar = SnackBar(content: Text(e?.message.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<void> storeTokenAndData(UserCredential userCredential) async {
    await storage.write(
        key: "token", value: userCredential.credential.token.toString());
    await storage.write(
        key: "userCredential", value: userCredential.toString());
  }

  Future<String> getToken() async {
    return await storage.read(key: 'token');
  }

  Future<void> logout(BuildContext context) async {
    try {
      await _googleSignIn.signOut();
      await auth.signOut();
      await storage.delete(key: 'token');
      await storage.delete(key: 'userCredential');
    } catch (e) {
      final snackbar = SnackBar(content: Text(e?.message.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }

  Future<void> verifyPhoneNumber(
      String phoneNumber, BuildContext context, Function setData) async {
    PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential phoneAuthCredential) async {
      showSnackBar(context, "Verification Completed");
    };

    PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException exception) async {
      showSnackBar(context, exception.message.toString());
    };
    PhoneCodeSent codeSent =
        (String verificationID, [int forceResendingToken]) {
      showSnackBar(context, "Verification Code Sent on the phone number");
      setData(verificationID);
    };
    PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationID) {
      showSnackBar(context, "Time out");
    };

    try {
      await auth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
    } catch (e) {
      showSnackBar(context, e?.message.toString());
    }
  }

  Future<void> signInWithPhoneNumber(
      String verificationId, String smsCode, BuildContext context) async {
    try {
      AuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: smsCode);

      UserCredential userCredential =
          await auth.signInWithCredential(credential);

      storeTokenAndData(userCredential);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (builder) => HomeScreen()),
          (route) => false);
      showSnackBar(context, "Logged In");
    } catch (e) {
      showSnackBar(context, e?.message.toString());
    }
  }

  void showSnackBar(BuildContext context, String text) {
    final snackbar = SnackBar(content: Text(text));
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}
