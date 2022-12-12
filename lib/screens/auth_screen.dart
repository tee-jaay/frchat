import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

import '../widgets/auth_form.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;

  void _submitAuthForm(
      String email, String password, String username, bool isLogin) async {
    var authAttemptResponse;
    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        authAttemptResponse = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        authAttemptResponse = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
      }
    } on PlatformException catch (err) {
      setState(() {
        _isLoading = false;
      });
      String? message = 'Please check your credentials';
      if (err.message != null) {
        message = err.message;
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message!),
        backgroundColor: Theme.of(context).errorColor,
      ));
    } catch (err) {
      setState(() {
        _isLoading = false;
      });
      if (kDebugMode) {
        print(err);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(
        _submitAuthForm,
        _isLoading
      ),
    );
  }
}
