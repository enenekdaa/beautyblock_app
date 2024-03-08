import 'dart:convert';

ChannelModel productFromJson(String str) => ChannelModel.fromJson(json.decode(str));

String productToJson(ChannelModel data) => json.encode(data.toJson());

class ChannelModel {
  int? channelId;
  String? channelName;
  String? channelProfileImage;
  String? createAt;
  String? status;
  String? updateAt;

  ChannelModel({
    this.channelId,
    this.channelName,
    this.channelProfileImage,
    this.createAt,
    this.status,
    this.updateAt,
  });

  factory ChannelModel.fromJson(Map<String, dynamic> json) => ChannelModel(
    channelId: json["channelId"],
    channelName: json["channelName"],
    channelProfileImage: json["channelProfileImage"],
    createAt: json["createAt"],
    status: json["status"],
    updateAt: json["updateAt"],
  );

  Map<String, dynamic> toJson() => {
    "channelId": channelId,
    "channelName": channelName,
    "channelProfileImage": channelProfileImage,
    "createAt": createAt,
    "status": status,
    "updateAt": updateAt,
  };
}
