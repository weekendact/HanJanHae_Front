import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hanjanhae/pages/LoginDetailsPage.dart';
import 'package:hanjanhae/pages/LoginPage.dart';
import 'package:hanjanhae/pages/MainPage.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';


/*
  내부 데베에서 토큰이 있는지 없는지 확인 후 있으면 로그인 후 메인페이지, 없으면 LoginDetail 페이지
 */

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp, // 화면 세로 고정
    DeviceOrientation.portraitDown,
  ]).then((_) {
    KakaoSdk.init(nativeAppKey: '61c625d463e984405890bd99a3030f99');
    runApp(const Hanjanhae());
  });
}

class Hanjanhae extends StatelessWidget {
  const Hanjanhae({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: const Locale('kr', 'KR'),
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
              (states) => Colors.transparent,
            ), // 텍스트 버튼 애니메이션 제거
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            overlayColor: MaterialStateColor.resolveWith(
              (states) => Colors.transparent,
            ), // Elevated 버튼 애니메이션 제거
          ),
        ),
        iconButtonTheme: IconButtonThemeData(
          style: ButtonStyle(
              overlayColor: MaterialStateColor.resolveWith(
            (states) => Colors.transparent,
          ) // 아이콘 버튼 애니메이션 제거
              ),
        ),
      ),
      // home: const LoginPage(),
      // home: const LoginDetailPage(),
      home: const MainPage(),
    );
  }
}
