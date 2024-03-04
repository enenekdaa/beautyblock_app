import 'package:get/get.dart';

class LoginController extends GetxController {

  //Login
  var loginButtonClicked = false.obs;



//  Login
 void onClickChanger(){
    loginButtonClicked.value =true;
  }
}