import 'package:beautyblock_app/config.dart';
import 'package:get/get.dart';
import '../../model/user_model.dart';

class JoinService extends GetConnect
{
  Future<UserModel> submitUserData() async {
    UserModel user = UserModel(
        channelId: 112,
        createAt: DateTime.now().toString(),
        roles: [],
        status: '활성',
        userEmail: 'test112@aaaa.com',
        userNickname: 'test112',
        userPassword: "qaz1234",
        userPhone: "01012341234",
        userProfileImage: "userProfileImage");

    final response = await post('${Server.baseUrl}/api/register' , user.toJson() ,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },);
    print(response.statusCode);
    print(response.body);
    if (response.statusCode.toString().startsWith('2')) {
      UserModel user = UserModel.fromJson(response.body);
      return user;
    } else {
      throw Exception();
    }
  }

}



