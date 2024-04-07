// ignore_for_file: file_names
import 'package:flutter/material.dart';

class AIChaPpage extends StatefulWidget {
  const AIChaPpage({super.key});

  @override
  State<AIChaPpage> createState() => _AIChaPpageState();
}

class _AIChaPpageState extends State<AIChaPpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: TextFormField(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.fromLTRB(15, 10, 10, 10),
                suffixIcon: GestureDetector(
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_circle_up_outlined,
                      size: 30,
                    ),
                    onPressed: () {},
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
