import 'package:flutter/material.dart';
import 'package:hanjanhae/DatabaseUrlAddresses.dart';
import 'package:hanjanhae/service/GoogleLogInService.dart';
import 'package:hanjanhae/service/SendLoginDataToDatabaseService.dart';

String base = '보드카';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () => signInWithGoogle(context),
          child: const Text('버튼'),
        ),
      ),
    );
  }
}