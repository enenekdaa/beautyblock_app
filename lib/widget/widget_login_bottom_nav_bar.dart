import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../auth/join/screen/join_main_screen.dart';
import '../config.dart';
import '../utils.dart';

class LoginBottomNavBarWidget extends StatelessWidget {
  const LoginBottomNavBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: Get.height * 0.1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                child: Text('Find ID', style: AppTheme.loginNaviBarFont),
                onTap: () {},
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                '|',
                style: TextStyle(color: Color.fromRGBO(220, 220, 220, 1)),
              ),
              SizedBox(
                width: 10,
              ),
              GestureDetector(
                child: Text('Reset Password', style: AppTheme.loginNaviBarFont),
                onTap: () {},
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                '|',
                style: TextStyle(color: Color.fromRGBO(220, 220, 220, 1)),
              ),
              SizedBox(
                width: 10,
              ),
              GestureDetector(
                child: Text('Sign Up', style: AppTheme.loginNaviBarFont),
                onTap: () {
                  Get.to(() => JoinMainScreen());
                },
              ),
            ],
          ),
          SizedBox(
            height: 50,
          )
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Padding(
          //       padding: EdgeInsets.symmetric(vertical: 15),
          //       child: Text("나중에 로그인 하실래요? ",
          //           style: TextStyle(
          //               fontFamily: 'NotoSans',
          //               fontSize: 10,
          //               color: GlobalBeautyColor.lightGray,
          //               fontWeight: FontWeight.bold)),
          //     ),
          //     Text('둘러보기',
          //         style: TextStyle(
          //             decoration: TextDecoration.underline,
          //             fontFamily: 'NotoSans',
          //             fontSize: 10,
          //             color: Color.fromRGBO(157, 157, 157, 1),
          //             fontWeight: FontWeight.bold))
          //   ],
          // )
        ],
      ),
    );
  }
}
