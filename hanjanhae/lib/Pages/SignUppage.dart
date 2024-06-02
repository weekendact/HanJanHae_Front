import 'package:flutter/material.dart';

class SignUppage extends StatefulWidget {
  const SignUppage({super.key});

  @override
  State<SignUppage> createState() => _SignUppageState();
}

class _SignUppageState extends State<SignUppage> {
  @override
  Widget build(BuildContext conntext) {
    return Scaffold(
      body: Column(
        children: [
          TextField(
            decoration: InputDecoration(),
          ),
        ],
      ),
    );
  }
}
