import 'package:flutter/material.dart';

class aichatpage extends StatefulWidget {
  const aichatpage({super.key});

  @override
  State<aichatpage> createState() => _aichatpageState();
}

class _aichatpageState extends State<aichatpage> {
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
