import 'package:beautyblock_app/auth/login/controller/login_controller.dart';
import 'package:beautyblock_app/auth/join/screen/join_main_screen.dart';
import 'package:beautyblock_app/auth/login/local_widget/login_scaffold.dart';
import 'package:beautyblock_app/config.dart';
import 'package:beautyblock_app/utils.dart';
import 'package:beautyblock_app/widget/widget_main_logo.dart';
import 'package:beautyblock_app/widget/widget_radius_button.dart';
import 'package:beautyblock_app/widget/widget_text_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  LoginController _loginController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => LoginScaffold(
          mainLogoWidget: MainLogoWidget(
            imageHeight: _loginController.loginButtonClicked.value
                ? Get.height * 0.1
                : Get.height * 0.2,
            imageCrossAlignment: _loginController.loginButtonClicked.value
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.center,
            contentGap: _loginController.loginButtonClicked.value ? 5.0 : 10.0,
          ),
          middleContent: middleContentChanger(),
          loginButton: RadiusButtonWidget(
            text: 'Login',
            backgroundColor: GlobalBeautyColor.buttonHotPink,
            onPress: _loginController.onClickChanger,
          ),
          bottomNavigationBar: bottomNavigationBar()
          ),
    );
  }

  Widget bottomNavigationBar() {
    return Container(
      alignment: Alignment.center,
      height: Get.height * 0.1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(child: Text('아이디 찾기', style: AppTheme.loginNaviBarFont),onTap: (){},),
              SizedBox(width: 10,),
              Text('|',style: TextStyle(color: Color.fromRGBO(220, 220, 220, 1)),),
              SizedBox(width: 10,),
              GestureDetector(child: Text('비밀번호 재설정', style: AppTheme.loginNaviBarFont),onTap: (){},),
              SizedBox(width: 10,),
              Text('|',style: TextStyle(color: Color.fromRGBO(220, 220, 220, 1)),),
              SizedBox(width: 10,),
              GestureDetector(child: Text('회원가입', style: AppTheme.loginNaviBarFont),onTap: (){Get.to(()=> JoinScreen());},),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Text("나중에 로그인 하실래요? ",
                    style: TextStyle(
                        fontFamily: 'NotoSans',
                        fontSize: 10,
                        color: GlobalBeautyColor.lightGray,
                        fontWeight: FontWeight.bold)),
              ),
              Text('둘러보기',
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontFamily: 'NotoSans',
                      fontSize: 10,
                      color: Color.fromRGBO(157, 157, 157, 1),
                      fontWeight: FontWeight.bold))
            ],
          )
        ],
      ),
    );
  }

  middleContentChanger() {
    print('===========middle in');

    if (_loginController.loginButtonClicked.value) {
      return Container(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            TextInputWidget(
              titleText: '이메일',
              hintText: '이메일을 입력해주세요.',
              isVisible: true,
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: TextInputWidget(
                titleText: '비밀번호',
                hintText: '비밀번호를 입력해주세요.',
                isVisible: true,
              ),
            )
          ],
        ),
      );
    } else {
      return Container(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Text(
            '당신의 아름다움을 위한 선택',
            style: AppTheme.smallTitleTextStyle,
          ));
    }
  }
}
