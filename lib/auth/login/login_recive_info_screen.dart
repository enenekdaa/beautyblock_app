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
import '../../widget/widget_sns_join_button.dart';
import '../../widget/widget_text_input.dart';
import '../join/controller/join_controller.dart';

class LoginReciveInfoScreen extends StatelessWidget {
  LoginReciveInfoScreen({super.key});

  final LoginController _loginController = Get.find();

  @override
  Widget build(BuildContext context) {
    return LoginRecieveScreenScaffold(
        mainLogoWidget: _buildMainLogo(),
        middleContent: Container(),
        // middleContent: _buildLoginReceiver(),
        // loginButton: _buildLoginButton(),
        loginButton: _buildSnsLoginButton(),
        bottomNavigationBar: LoginBottomNavBarWidget());
  }

  Widget _buildMainLogo() {
    return MainLogoWidget(
      imageHeight: Get.height * 0.2,
      imageCrossAlignment: CrossAxisAlignment.center,
      contentGap: 24.0,
    );
  }

  Widget _buildSnsLoginButton() {
    return Container(
      height: Get.height * 0.15,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SNSJoinButtonWidget(
                  snsIcon: Image.asset('assets/images/ic_apple.png'),
                  onPress: () {
                    _loginController.signInWithApple();
                  }),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.02),
                child: SNSJoinButtonWidget(
                    snsIcon: Image.asset('assets/images/ic_google.png'),
                    onPress: () {
                      _loginController.signInWithGoogle();
                    }),
              ),
              // SNSJoinButtonWidget(
              //     snsIcon: Image.asset('assets/images/ic_facebook.png'),
              //     onPress: () {
              //       _joinController.signInWithFacebook();
              //     }),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildLoginReceiver() {
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

  Widget _buildLoginButton() {
    return RadiusButtonWidget(
        text: 'Login',
        backgroundColor: GlobalBeautyColor.buttonHotPink,
        onPress: () {
          // _loginController.loginApp().then((value) =>
          //     Get.to(HomeMainScreen())
          // );
          Get.to(HomeMainScreen());
        });
  }
}
