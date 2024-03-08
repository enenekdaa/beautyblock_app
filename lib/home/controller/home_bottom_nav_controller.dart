import 'package:beautyblock_app/config.dart';
import 'package:beautyblock_app/home/screen/home_mypage_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../main_bottom_navbar_tab/screen/tab_channel_screen.dart';
import '../main_bottom_navbar_tab/screen/tab_fan_screen.dart';
import '../main_bottom_navbar_tab/screen/tab_home_screen.dart';


class BottomNavBarController extends GetxController {
  static BottomNavBarController get to => Get.find();
  var bottomItems = <BottomNavigationBarItem>[].obs;
  var pages = [].obs;
  var bottomNavCurrentIndex = 0.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    setBottomItems();
    pages.value = [
      TabHomeScreen(),
      TabChannelScreen(),
      Text('data'),
      TabFanScreen(),
      HomeMyPageScreen(),
    ];
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    bottomItems.value =[];
    pages.value = [];
  }
  void onItemTapped(int index) {
    bottomNavCurrentIndex.value = index;
  }
  void setBottomItems() {
    bottomItems.value = [
      BottomNavigationBarItem(
        activeIcon: SvgPicture.asset('assets/images/ic_home.svg',color: GlobalBeautyColor.buttonHotPink,matchTextDirection: true,),
        icon: SvgPicture.asset('assets/images/ic_home.svg'),
        label: 'HOME',
      ),
      BottomNavigationBarItem(
        activeIcon: SvgPicture.asset('assets/images/ic_channel.svg',color: GlobalBeautyColor.buttonHotPink,matchTextDirection: true,),
        icon: SvgPicture.asset('assets/images/ic_channel.svg'),
        label: 'CHANNEL',
      ),
      BottomNavigationBarItem(
        activeIcon: SvgPicture.asset('assets/images/ic_camera.svg',color: GlobalBeautyColor.buttonHotPink,matchTextDirection: true,),
        icon: SvgPicture.asset('assets/images/ic_camera.svg'),
        label: 'CAMERA',
      ),
      BottomNavigationBarItem(
        activeIcon: SvgPicture.asset('assets/images/ic_fan.svg',color: GlobalBeautyColor.buttonHotPink,matchTextDirection: true,),
        icon: SvgPicture.asset('assets/images/ic_fan.svg'),
        label: 'FAN',
      ),
      BottomNavigationBarItem(
        activeIcon: SvgPicture.asset('assets/images/ic_profile.svg',color: GlobalBeautyColor.buttonHotPink,matchTextDirection: true,),
        icon: SvgPicture.asset('assets/images/ic_profile.svg'),
        label: 'MYPAGE',
      ),
    ];
  }
}