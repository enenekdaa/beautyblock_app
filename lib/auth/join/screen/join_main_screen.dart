import 'package:beautyblock_app/auth/join/local_widget/join_main_scaffold.dart';
import 'package:beautyblock_app/config.dart';
import 'package:beautyblock_app/utils.dart';
import 'package:beautyblock_app/widget/widget_main_logo.dart';
import 'package:beautyblock_app/widget/widget_radius_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class JoinScreen extends StatelessWidget {
  const JoinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return JoinMainScreenScaffold(
      mainLogoWidget: MainLogoWidget(
        imageHeight: Get.height * 0.2,
        imageCrossAlignment: CrossAxisAlignment.center,
      ),
      middleContent: middleContents(),
      joinButton: RadiusButtonWidget(
        text: "Join",
        backgroundColor: GlobalBeautyColor.buttonHotPink,
        onPress: () {Get.toNamed('/termsScreen');},
      ),
    );
  }

  Widget middleContents() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15),
      child: Column(
        children: [
          Text(
            "내가 찾는 뷰티 비지니스의 모든 것",
            style: AppTheme.smallTitleTextStyle,
          ),
          Text(
            "글로벌 뷰티 비지니스 앱",
            style: AppTheme.smallTitleTextStyle,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Beauty Block을 통해 나만의 뷰티 인맥을 만들어보세요.",
            style: AppTheme.smallTitleTextStyle
                .copyWith(fontSize: 11, fontWeight: FontWeight.w500),
          ),
          Text("뷰티 비지니스의 즐거움",
              style: AppTheme.smallTitleTextStyle.copyWith(
                fontSize: 11,
                fontWeight: FontWeight.w500,
              )),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
