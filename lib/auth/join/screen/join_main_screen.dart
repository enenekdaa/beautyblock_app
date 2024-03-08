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
      joinButton: _buildJoinButton(),
      bottomButtonSection: _buildBottomSNSJoinButton(),
    );
  }

  Widget _buildMainLogo(){
    return MainLogoWidget(
      imageHeight: Get.height * 0.2,
      imageCrossAlignment: CrossAxisAlignment.center,
    );
  }

  Widget _buildmiddleContents() {
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
        ],
      ),
    );
  }

  Widget _buildJoinButton(){
    return RadiusButtonWidget(
      text: "Join",
      backgroundColor: GlobalBeautyColor.buttonHotPink,
      onPress: () {Get.toNamed('/termsScreen');},
    );
  }

  Widget _buildBottomSNSJoinButton(){
    return Container(
      height: Get.height * 0.15,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Divider(thickness: 1,color:Color.fromRGBO(181, 181, 181, 0.7) ,),
              Positioned(top: 0,child: Container(padding: EdgeInsets.symmetric(horizontal: Get.width * 0.03),color:Colors.white,child: Text('OR',style: AppTheme.boldMyPageTextStyle.copyWith(fontSize: 12,fontWeight: FontWeight.w500,height: 1.5),))),
            ],
          ),
          SizedBox(height: Get.height * 0.02,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SNSJoinButtonWidget(snsIcon: Image.asset('assets/images/ic_apple.png'), onPress: (){}),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.02),
                child: SNSJoinButtonWidget(snsIcon: Image.asset('assets/images/ic_google.png'), onPress: (){


                  _joinController.signInWithGoogle();}),
              ),
              SNSJoinButtonWidget(snsIcon: Image.asset('assets/images/ic_facebook.png'), onPress: (){_joinController.signInWithFacebook();}),
            ],
          )
        ],
      ),
    );
  }
}
