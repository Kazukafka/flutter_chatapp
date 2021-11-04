import 'package:flutter/material.dart';
import 'package:messenger_clone/services/auth.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("messenger clone"),
        ),
        body: Center(
            child: GestureDetector(
                onTap: () {
                  AuthMethods().SignInWithGoogle(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: Color(0xffDB4437),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text("Sign In With Google",
                      style: TextStyle(fontSize: 16, color: Colors.white)),
                ))));
  }
}
