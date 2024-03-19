import 'package:beautyblock_app/auth/login/controller/login_controller.dart';
import 'package:beautyblock_app/auth/login/local_widget/login_scaffold.dart';
import 'package:beautyblock_app/auth/login/login_recive_info_screen.dart';
import 'package:beautyblock_app/config.dart';
import 'package:beautyblock_app/utils.dart';
import 'package:beautyblock_app/widget/widget_login_bottom_nav_bar.dart';
import 'package:beautyblock_app/widget/widget_main_logo.dart';
import 'package:beautyblock_app/widget/widget_radius_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final LoginController _loginController = Get.find();

  @override
  Widget build(BuildContext context) {
    //240311 jaesung. bottomNavigationBar 시연용으로 주석처리
    return LoginScaffold(
      mainLogoWidget: _buildMainLogo(),
      middleContent: _buildMiddleText(),
      loginButton: _buildLoginButton(),
      bottomNavigationBar: Container(),
      // bottomNavigationBar: LoginBottomNavBarWidget()
    );
  }

  Widget _buildMainLogo() {
    return MainLogoWidget(
      imageHeight: Get.height * 0.2,
      imageCrossAlignment: CrossAxisAlignment.center,
      contentGap: 10.0,
    );
  }

  Widget _buildLoginButton() {
    return RadiusButtonWidget(
        text: 'Login',
        backgroundColor: GlobalBeautyColor.buttonHotPink,
        onPress: () {
          Get.offAll(() => LoginReciveInfoScreen());
        });
  }

  Container _buildMiddleText() {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Text(
          'Your Beauty Choices',
          style: AppTheme.smallTitleTextStyle,
        ));
  }
}
