import 'package:flutter/material.dart';

class recipepage extends StatefulWidget {
  const recipepage({super.key});

  @override
  State<recipepage> createState() => _recipepageState();
}

class _recipepageState extends State<recipepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('recipe'),
      ),
    );
  }
}