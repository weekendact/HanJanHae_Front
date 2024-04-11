// ignore_for_file: unnecessary_import, file_names
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:hanjanhae/DatabaseUrlAddresses.dart';
import 'package:hanjanhae/service/LoginDuplicateCheckService.dart';

class LoginDetailPage extends StatefulWidget {
  const LoginDetailPage({super.key});

  @override
  State<LoginDetailPage> createState() => _LoginDetailPageState();
}

class _LoginDetailPageState extends State<LoginDetailPage> {
  String? selectedChoiceGender;

  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController nicknameController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  int age = 0;

  @override
  void dispose() {
    nicknameController.dispose();
    ageController.dispose();
    super.dispose();
  }

  String? nicknameErrorText; // 닉네임 에러 텍스트
  String? genderErrorText; // 성별 에러 텍스트
  String? ageErrorText; // 나이 에러 텍스트

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
        title: const Text(
          "회원가입",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Form(
          key: formkey,
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 30, 0, 5),
                  child: const Text(
                    "뭐라고 부를까요?",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        // width: MediaQuery.of(context).size.width,
                        height: 50,
                        child: TextFormField(
                          style: const TextStyle(
                            fontSize: 20.0,
                          ),
                          controller: nicknameController,
                          textAlign: TextAlign.center,
                          textAlignVertical: TextAlignVertical.bottom,
                          decoration: InputDecoration(
                            hintText: "닉네임",
                            // errorText: nicknameErrorText ?? "",
                            // errorStyle: ,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      width: 110.0,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          minimumSize: const Size(50, 50),
                        ),
                        onPressed: () {
                          // 엔드포인트 /nicknameDuplicate , 파라미터 값 전달 후 처리
                          final String nickname = nicknameController.text;
                          print(nickname);
                          print(nicknameDuplicate(
                              nickname, Endpoints.nicknameDuplicateUrl));
                        },
                        child: const Text(
                          "중복확인",
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 30, 0, 5),
                  child: const Text(
                    "성별을 알려주세요!",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Center(
                  child: genterch(),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 30, 0, 5),
                  child: const Text(
                    "나이를 알려주세요!",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: TextFormField(
                    style: const TextStyle(
                      fontSize: 20.0,
                    ),
                    controller: ageController,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly, // 숫자만 입력
                      LengthLimitingTextInputFormatter(2), // 2자리 제한
                    ],
                    textAlign: TextAlign.center,
                    textAlignVertical: TextAlignVertical.bottom,
                    decoration: InputDecoration(
                      hintText: "나이",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onChanged: (value) {
                    },
                  ),
                ),
                const Expanded(
                  child: Center(
                    child: null,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      minimumSize: const Size(50, 50),
                    ),
                    onPressed: () {
                      age = int.parse(ageController.text);

                      print(nicknameController.text);
                      print(age);
                      print('$selectedChoiceGender');
                      /*
          
                        null 값일 경우 오류 메시지 생성
                        null 값이 아닌 경우 데이터베이스에 값 전송 및 메인 페이지로 이동
          
                       */
                    },
                    child: const Text(
                      "회원가입",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // void submit() {
  //   if
  // }

  Widget genterch() {
    return Wrap(
      spacing: 10,
      children: [
        ChoiceChip(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          label: const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 43,
              vertical: 3,
            ),
            child: Text(
              "남자",
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
          ),
          selected: selectedChoiceGender == "M",
          onSelected: (selected) {
            setState(() {
              selectedChoiceGender = selected ? "M" : null;
            });
          },
        ),
        ChoiceChip(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          label: const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 43,
              vertical: 3,
            ),
            child: Text(
              "여자",
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
          ),
          selected: selectedChoiceGender == "F",
          onSelected: (selected) {
            setState(() {
              selectedChoiceGender = selected ? "F" : null;
            });
          },
        ),
      ],
    );
  }
}
