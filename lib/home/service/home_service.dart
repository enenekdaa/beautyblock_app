import 'dart:ffi';

import 'package:beautyblock_app/home/controller/home_controller.dart';
import 'package:beautyblock_app/model/channel_model.dart';
import 'package:beautyblock_app/model/roles_model.dart';
import 'package:get/get.dart';

import '../../config.dart';

class HomeService extends GetConnect {
  Future<ChannelModel> fetchChannels() async {
    final response =
    await get('${Server.baseUrl}/api/channels');

    if (response.statusCode == 200) {
      ChannelModel channels = ChannelModel.fromJson(response.body);
      return channels;
    } else {
      throw Exception('Failed to load Channel');
    }
  }

  Future<RolesModel> fetchRoles() async {
    final response = await get('${Server.baseUrl}/api/roles');

    if (response.statusCode == 200) {
      RolesModel roles = RolesModel.fromJson(response.body);
      return roles;
    } else {
      throw Exception('Failed to load Roles');
    }
  }

  // Future<http.Response> submitChannel() async {
  //   Channel channel = Channel(
  //       channelId: 001,
  //       channelName: '',
  //       channelProfileImage: 'channelProfileImage',
  //       createAt: 'createAt',
  //       status: 'status',
  //       updateAt: 'updateAt');
  //   return await http.post(Uri.parse('${Server.baseUrl}/api/channels'),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       },
  //       body: jsonEncode(channel.toJson()));
  // }
  //
  // Future<http.Response> submitRole() async {
  //   Roles role = Roles(id: 001, roleName: 'roleName');
  //   return await http.post(Uri.parse('${Server.baseUrl}/api/roles'),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       },
  //       body: jsonEncode(role.toJson()));
  // }

  Future<void> deleteChannel(Int userId,Int channelId) async {
    delete('${Server.baseUrl}/api/channels/$userId/$channelId');
  }

  Future<void> deleteRole(Int userId,Int roleId) async {
    delete(
      '${Server.baseUrl}/api/roles/$userId/$roleId',
    );
  }
}