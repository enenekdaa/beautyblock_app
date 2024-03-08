// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

UserModel productFromJson(String str) => UserModel.fromJson(json.decode(str));

String productToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  bool? accountNonExpired;
  bool? accountNonLocked;
  List<Authority>? authorities;
  int? channelId;
  String? createAt;
  bool? credentialsNonExpired;
  bool? enabled;
  String? password;
  List<Role>? roles;
  String? status;
  String? userEmail;
  int? userId;
  String? userNickname;
  String? userPassword;
  String? userPhone;
  String? userProfileImage;
  String? username;

  UserModel({
    this.accountNonExpired,
    this.accountNonLocked,
    this.authorities,
    this.channelId,
    this.createAt,
    this.credentialsNonExpired,
    this.enabled,
    this.password,
    this.roles,
    this.status,
    this.userEmail,
    this.userId,
    this.userNickname,
    this.userPassword,
    this.userPhone,
    this.userProfileImage,
    this.username,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    accountNonExpired: json["accountNonExpired"],
    accountNonLocked: json["accountNonLocked"],
    authorities: List<Authority>.from(json["authorities"].map((x) => Authority.fromJson(x))),
    channelId: json["channelId"],
    createAt: json["createAt"],
    credentialsNonExpired: json["credentialsNonExpired"],
    enabled: json["enabled"],
    password: json["password"],
    roles: List<Role>.from(json["roles"].map((x) => Role.fromJson(x))),
    status: json["status"],
    userEmail: json["userEmail"],
    userId: json["userId"],
    userNickname: json["userNickname"],
    userPassword: json["userPassword"],
    userPhone: json["userPhone"],
    userProfileImage: json["userProfileImage"],
    username: json["username"],
  );

  Map<String, dynamic> toJson() => {
    "accountNonExpired": accountNonExpired,
    "accountNonLocked": accountNonLocked,
    "authorities": authorities != null ? List<dynamic>.from(authorities!.map((x) => x.toJson())) : [],
    "channelId": channelId,
    "createAt": createAt,
    "credentialsNonExpired": credentialsNonExpired,
    "enabled": enabled,
    "password": password,
    "roles": roles !=null ? List<dynamic>.from(roles!.map((x) => x.toJson())) : [],
    "status": status,
    "userEmail": userEmail,
    "userId": userId,
    "userNickname": userNickname,
    "userPassword": userPassword,
    "userPhone": userPhone,
    "userProfileImage": userProfileImage,
    "username": username,
  };
}

class Authority {
  String authority;

  Authority({
    required this.authority,
  });

  factory Authority.fromJson(Map<String, dynamic> json) => Authority(
    authority: json["authority"],
  );

  Map<String, dynamic> toJson() => {
    "authority": authority,
  };
}

class Role {
  int? id;
  String? roleName;

  Role({
    this.id,
    this.roleName,
  });

  factory Role.fromJson(Map<String, dynamic> json) => Role(
    id: json["id"],
    roleName: json["roleName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "roleName": roleName,
  };
}
