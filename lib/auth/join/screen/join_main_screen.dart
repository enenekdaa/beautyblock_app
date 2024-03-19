import 'package:beautyblock_app/auth/join/controller/join_controller.dart';
import 'package:beautyblock_app/auth/join/local_widget/join_main_scaffold.dart';
import 'package:beautyblock_app/auth/service/join_service.dart';
import 'package:beautyblock_app/config.dart';
import 'package:beautyblock_app/utils.dart';
import 'package:beautyblock_app/widget/widget_main_logo.dart';
import 'package:beautyblock_app/widget/widget_radius_button.dart';
import 'package:beautyblock_app/widget/widget_sns_join_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class JoinMainScreen extends StatelessWidget {
  JoinMainScreen({super.key});

  final JoinController _joinController = Get.find();
  @override
  Widget build(BuildContext context) {
    return JoinMainScreenScaffold(
      mainLogoWidget: _buildMainLogo(),
      middleContent: _buildmiddleContents(),
      joinButton: Container(),
      // joinButton: _buildJoinButton(),
      bottomButtonSection: _buildBottomSNSJoinButton(),
    );
  }

  Widget _buildMainLogo() {
    return MainLogoWidget(
      imageHeight: Get.height * 0.2,
      imageCrossAlignment: CrossAxisAlignment.center,
      contentGap: 24.0,
    );
  }

  Widget _buildmiddleContents() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15),
      child: Column(
        children: [
          Text(
            "Everything you're looking for in the beauty industry",
            style: AppTheme.smallTitleTextStyle,
          ),
          Text(
            "Global beauty business app",
            style: AppTheme.smallTitleTextStyle,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Create your own beauty network through BeautyBlock.",
            style: AppTheme.smallTitleTextStyle
                .copyWith(fontSize: 11, fontWeight: FontWeight.w500),
          ),
          Text("Enjoy your beauty business.",
              style: AppTheme.smallTitleTextStyle.copyWith(
                fontSize: 11,
                fontWeight: FontWeight.w500,
              )),
        ],
      ),
    );
  }

  Widget _buildJoinButton() {
    return RadiusButtonWidget(
      text: "Join",
      backgroundColor: GlobalBeautyColor.buttonHotPink,
      onPress: () {
        Get.toNamed('/termsScreen');
      },
    );
  }

  Widget _buildBottomSNSJoinButton() {
    //240311. jaesung.
    //remove -----OR-----
    //remove Facebook Login Button
    return Container(
      height: Get.height * 0.15,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Stack(
          //   alignment: Alignment.center,
          //   children: [
          //     Divider(
          //       thickness: 1,
          //       color: Color.fromRGBO(181, 181, 181, 0.7),
          //     ),
          //     Positioned(
          //         top: 0,
          //         child: Container(
          //             padding:
          //                 EdgeInsets.symmetric(horizontal: Get.width * 0.03),
          //             color: Colors.white,
          //             child: Text(
          //               'OR',
          //               style: AppTheme.boldMyPageTextStyle.copyWith(
          //                   fontSize: 12,
          //                   fontWeight: FontWeight.w500,
          //                   height: 1.5),
          //             ))),
          //   ],
          // ),
          // SizedBox(
          //   height: Get.height * 0.02,
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SNSJoinButtonWidget(
                  snsIcon: Image.asset('assets/images/ic_apple.png'),
                  onPress: () {
                    _joinController.signInWithApple();
                  }),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.02),
                child: SNSJoinButtonWidget(
                    snsIcon: Image.asset('assets/images/ic_google.png'),
                    onPress: () {
                      _joinController.signInWithGoogle();
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
}
