import 'package:beautyblock_app/auth/login/controller/login_controller.dart';
import 'package:beautyblock_app/auth/login/local_widget/login_recieve_info_screen_scaffold.dart';
import 'package:beautyblock_app/home/screen/home_main_screen.dart';
import 'package:beautyblock_app/widget/widget_login_bottom_nav_bar.dart';
import 'package:beautyblock_app/widget/widget_main_logo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../config.dart';
import '../../widget/widget_radius_button.dart';
import '../../widget/widget_text_input.dart';

class LoginReciveInfoScreen extends StatelessWidget {
   LoginReciveInfoScreen({super.key});

   final LoginController _loginController = Get.find();

  @override
  Widget build(BuildContext context) {
    return LoginRecieveScreenScaffold(
        mainLogoWidget: _buildMainLogo(),
        middleContent: _buildLoginReceiver(),
        loginButton: _buildLoginButton(),
        bottomNavigationBar: LoginBottomNavBarWidget());
  }

  Widget _buildMainLogo(){
    return MainLogoWidget(
      imageHeight: Get.height * 0.1,
      imageCrossAlignment: CrossAxisAlignment.start,
      contentGap: 5.0  ,
    );
  }
  Widget _buildLoginReceiver(){
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          TextInputWidget(
            titleText: '이메일',
            hintText: '이메일을 입력해주세요.',
            isGuideTextVisible: true,
            controller: _loginController.userIdController,
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: TextInputWidget(
              titleText: '비밀번호',
              hintText: '비밀번호를 입력해주세요.',
              isGuideTextVisible: true,
              controller: _loginController.passwordController,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildLoginButton(){
    return RadiusButtonWidget(
        text: 'Login',
        backgroundColor: GlobalBeautyColor.buttonHotPink,
        onPress: (){
          // _loginController.loginApp().then((value) =>
          //     Get.to(HomeMainScreen())
          // );
           Get.to(HomeMainScreen());
        });
  }

}
