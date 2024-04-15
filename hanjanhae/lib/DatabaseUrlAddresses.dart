// ignore_for_file: file_names

class ApiConstants {
  static const String baseUrl = "http://10.200.43.153:8080/Users";
}

class Endpoints {
  // 로그인 관련
  static const String signUpUrl = "/socialSignUp"; // 소셜 회원가입
  static const String logInUrl = "socialLogin"; // 소셜 로그인
  static const String nicknameDuplicateUrl = "/nicknameDuplicate"; // 닉네임 중복 확인
  static const String userDetailUrl = "/usersSaveDetails"; // 유저 상세정보
  static const String deleteUserUrl = "/deleteUsers"; // 유저 삭제

  // ?
}