import 'package:chat_app/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupPage extends StatefulWidget {
  final String title = "Signup";

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool _initialized = false;
  bool _error = false;

  @override
  void initState() {
    super.initState();
    sendVerificationCode();
  }

  void sendVerificationCode() async {
    print("SENDING CODE");
    await Firebase.initializeApp();
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.verifyPhoneNumber(
        phoneNumber: '+91 9916152333',
        codeSent: (String verificationId, int resendToken) async {
          print("CODE SENT");
        },
        verificationCompleted: (PhoneAuthCredential credential) async {
          print(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.code);
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          print(verificationId);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Container(
          child: Text("Test"),
        ));
  }
}
