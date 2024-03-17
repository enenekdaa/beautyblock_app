import 'package:beautyblock_app/auth/login/login_recive_info_screen.dart';
import 'package:beautyblock_app/home/controller/home_controller.dart';
import 'package:beautyblock_app/home/local_widget/scaffold/home_mypage_screen_scaffold.dart';
import 'package:beautyblock_app/home/screen/home_channel_detail_screen.dart';
import 'package:beautyblock_app/home/screen/home_mypage_favorites_channel_screen.dart';
import 'package:beautyblock_app/home/screen/home_mypage_mychannel_screen.dart';
import 'package:beautyblock_app/home/screen/home_mypage_myvideo_screen.dart';
import 'package:beautyblock_app/home/screen/home_policy_screen.dart';
import 'package:beautyblock_app/model/login_model.dart';
import 'package:beautyblock_app/utils.dart';
import 'package:beautyblock_app/widget/widget_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../auth/login/controller/login_controller.dart';
import '../../config.dart';
import '../../widget/widget_radius_button.dart';

class HomeMyPageScreen extends StatelessWidget {
  HomeMyPageScreen({super.key});

  final HomeController _homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(builder: (controller) {
      return HomeMypageScreenScaffold(
          homeAppbarSection: _buildAppbar(),
          profileImgSection: profileImg(),
          listTitleSection: _buildList(),
          bottomButtonSection: _buildbottomButton());
    });
  }

  Widget _buildAppbar() {
    return AppbarWidget(
      isMain: true,
      appbarText: '마이페이지',
      centerTitle: true,
    );
  }

  Widget profileImg() {
    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: Container(
            height: Get.height * 0.15,
            width: Get.width * 0.3,
            child: LoginController.to.getProfile() == ''
                ? CircleAvatar(
                    radius: Get.height * 0.15,
                    backgroundImage: AssetImage(
                      'assets/images/img_test.png',
                    ))
                : CircleAvatar(
                    radius: Get.height * 0.15,
                    backgroundImage:
                        NetworkImage(LoginController.to.getProfile()),
                  ),
          ),
        ),
        Positioned(
            bottom: 0,
            right: Get.width * 0.27,
            child: IconButton(
              icon: SvgPicture.asset('assets/images/ic_photo.svg'),
              onPressed: () {
                LoginController.to.setProfile();
              },
            ))
      ],
    );
  }

  Widget _buildList() {
    return Column(
      children: [
        // myPageListTile(
        //     '즐겨찾기', SvgPicture.asset('assets/images/ic_front_arrow.svg'), () {
        //   Get.to(HomeMyPageFavoritesChannelScreen());
        // }),
        myPageListTile(
            '내 채널', SvgPicture.asset('assets/images/ic_front_arrow.svg'), () {
          Get.to(() => HomeChannelDetailScreen(id: LoginController.to.getId()));
        }),
        // myPageListTile(
        //     '나의 영상', SvgPicture.asset('assets/images/ic_front_arrow.svg'), () {
        //   Get.to(HomeMyPageMyVideoScreen());
        // }),
        Divider(
          thickness: 1,
          color: Color.fromRGBO(171, 169, 163, 0.24),
        ),
        // myPageListTile('구매결제 내역',
        //     SvgPicture.asset('assets/images/ic_front_arrow.svg'), () {}),
        // myPageListTile('문의하기',
        //     SvgPicture.asset('assets/images/ic_front_arrow.svg'), () {}),
        myPageListTile(
            '아이디',
            Text(
              LoginController.to.getEmail(),
              style: AppTheme.boldMyPageTextStyle,
            ),
            () {}),
        myPageListTile(
            '닉네임',
            Text(
              LoginController.to.getNick(),
              style: AppTheme.boldMyPageTextStyle,
            ),
            () {}),
        // myPageListTile('비밀번호 재설정',
        //     SvgPicture.asset('assets/images/ic_front_arrow.svg'), () {}),
        Divider(
          color: Color.fromRGBO(171, 169, 163, 0.24),
        ),
        myPageListTile(
            '서비스 이용약관', SvgPicture.asset('assets/images/ic_front_arrow.svg'),
            () {
          Get.to(() => HomePolicyScreen(type: 'terms'));
        }),
        myPageListTile(
            '개인정보 취급 방침', SvgPicture.asset('assets/images/ic_front_arrow.svg'),
            () {
          Get.to(() => HomePolicyScreen(type: 'privacy'));
        }),
        myPageListTile(
            '이벤트 및 정보 수신', SvgPicture.asset('assets/images/ic_front_arrow.svg'),
            () {
          Get.to(() => HomePolicyScreen(type: 'marketing'));
        }),
        myPageListTile(
            '알림허용',
            Obx(() => Switch(
                  value: _homeController.getSwitchValue('isAlarm'),
                  activeColor: GlobalBeautyColor.buttonHotPink,
                  // 활성화 상태의 thumb 색상
                  activeTrackColor: Color.fromRGBO(171, 169, 163, 0.12),
                  // 활성화 상태의 track 색상
                  inactiveThumbColor: Color.fromRGBO(213, 212, 208, 1),
                  // 비활성화 상태의 thumb 색상
                  inactiveTrackColor: Color.fromRGBO(171, 169, 163, 0.24),
                  trackOutlineColor: MaterialStateProperty.resolveWith(
                    (final Set<MaterialState> states) {
                      if (states.contains(MaterialState.selected)) {
                        return null;
                      }
                      return Colors.transparent;
                    },
                  ),
                  onChanged: (value) {
                    _homeController.updateSwitchValue('isAlarm', value);
                  },
                )),
            () {}),
      ],
    );
  }

  Widget _buildbottomButton() {
    return RadiusButtonWidget(
      backgroundColor: GlobalBeautyColor.buttonHotPink,
      text: '로그아웃',
      onPress: () {
        LoginController.to.logout();
      },
    );
  }

  ListTile myPageListTile(text, trailing, onPress) {
    return ListTile(
      dense: true,
      title: Text(
        text,
        style: AppTheme.boldMyPageTextStyle,
      ),
      trailing: trailing,
      onTap: onPress,
    );
  }
}
