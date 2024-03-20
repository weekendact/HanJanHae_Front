import 'package:flutter/material.dart';
import 'package:hanjanhae/pages/LoginPage.dart';
// import 'package:hanjanhae/pages/LoginPage.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';


void main() {
  KakaoSdk.init(nativeAppKey: 'f54eff33e9760d2c54bf28c39f04acb0');
  runApp(const hanjanhae());
}

class hanjanhae extends StatelessWidget {
  const hanjanhae({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'hanjanhae Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Jalnan',
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          splashColor: Colors.transparent,
          elevation: 0.0,
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            foregroundColor: const MaterialStatePropertyAll(Colors.black),
            overlayColor: MaterialStateColor.resolveWith(
                (states) => Colors.transparent), // 텍스트 버튼 애니메이션 제거
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              overlayColor: MaterialStateColor.resolveWith(
                  (states) => Colors.transparent), // Elevated 버튼 애니메이션 제거
              ),
        ),
        iconButtonTheme: IconButtonThemeData(
          style: ButtonStyle(
              overlayColor: MaterialStateColor.resolveWith(
                  (states) => Colors.transparent) // 아이콘 버튼 애니메이션 제거
              ),
        ),
      ),
      // home: const mainpage(),
      home: const loginpage(),
      // home: const SampleScreen(),
    );
  }
}
