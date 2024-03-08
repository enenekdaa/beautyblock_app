import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../config.dart';
import '../../../model/login_model.dart';
class LoginController extends GetxController {
  static LoginController get to => Get.find();
  GetConnect getConnect = GetConnect();

  //Login
  var passwordController = TextEditingController();
  var userIdController = TextEditingController();


  Future<String> loginApp() async {
    Login login =  Login(password: passwordController.text, userName: userIdController.text);

    final response = await getConnect.post('${Server.baseUrl}/api/login' ,
        {
          "password": 'qaz1234',
          "userName": 'test112@aaaa.com'
        } ,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
    print(response.request!.bodyBytes);

    print(response.statusCode);
    print(response.body);
    var token = response.body['token'];
    print(token);
    return token;
  }
}