// ignore_for_file: file_names

class ApiConstants {
  static const String baseUrl = "http://10.200.73.72:8080/";
}

class Endpoints {
  // 로그인 관련
  static const String signUpUrl = "users/socialSignUp"; // 소셜 회원가입
  static const String logInUrl = "users/socialLogin"; // 소셜 로그인
  static const String nicknameDuplicateUrl = "users/nicknameDuplicate"; // 닉네임 중복 확인
  static const String userDetailUrl = "users/usersSaveDetails"; // 유저 상세정보

  // 유저 정보 삭제
  static const String deleteUserUrl = "users/deleteUsers"; // 유저 삭제

  // ?
  static const String baseLiquorUrl = "drink/cocktails/search";
}