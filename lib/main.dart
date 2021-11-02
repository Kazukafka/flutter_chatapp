import 'package:flutter/material.dart';

main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            const Text(
              "Login Page",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                    hintText: "Enter your email",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: TextField(
                controller: passwordController,
                decoration: InputDecoration(
                    hintText: "Enter your password",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
            ),
            ElevatedButton(
                style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 80)),
                onPressed: () {},
                child: Text("Login"))
          ],
        ),
      ),
    );
  }
}
