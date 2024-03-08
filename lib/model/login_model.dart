import 'dart:convert';

Login productFromJson(String str) => Login.fromJson(json.decode(str));

String productToJson(Login data) => json.encode(data.toJson());

class Login {
  String password;
  String userName;

  Login({
    required this.password,
    required this.userName,
  });

  factory Login.fromJson(Map<String, dynamic> json) => Login(
    password: json["password"],
    userName: json["userName"],
  );

  Map<String, dynamic> toJson() => {
    "password": password,
    "userName": userName,
  };
}