import 'dart:convert';

RolesModel productFromJson(String str) => RolesModel.fromJson(json.decode(str));

String productToJson(RolesModel data) => json.encode(data.toJson());

class RolesModel {
  int? id;
  String? roleName;

  RolesModel({
     this.id,
     this.roleName,
  });

  factory RolesModel.fromJson(Map<String, dynamic> json) => RolesModel(
    id: json["id"],
    roleName: json["roleName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "roleName": roleName,
  };
}
