import 'package:flutter/material.dart';

class postingpage extends StatefulWidget {
  const postingpage({super.key});

  @override
  State<postingpage> createState() => _postingpageState();
}

class _postingpageState extends State<postingpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posting'),
      ),
    );
  }
}