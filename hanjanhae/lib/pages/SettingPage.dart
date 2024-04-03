import 'package:flutter/material.dart';
import 'package:hanjanhae/service/LogOutService.dart';
import 'package:hanjanhae/service/userSecureStorageService.dart';

class settingspage extends StatefulWidget {
  const settingspage({super.key});

  @override
  State<settingspage> createState() => _settingspageState();
}

class _settingspageState extends State<settingspage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              TextButton(
                onPressed: () async {
                  WidgetsFlutterBinding.ensureInitialized(); // 바인딩
                  SecureStorageService().removeAll();
                  signOut(context);
                },
                child: const Row(
                  children: [
                    Text(
                      "로그아웃",
                      style: TextStyle(
                        fontSize: 20.0,
                        // decoration: TextDecoration.underline,
                      ),
                    ),
                    Expanded(child: Center(child: null,)),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
