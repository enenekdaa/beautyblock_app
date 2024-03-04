import 'package:beautyblock_app/config.dart';
import 'package:beautyblock_app/home/controller/home_bottom_nav_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class BottomNavBar extends StatelessWidget {
   BottomNavBar({super.key});

  final BottomNavBarController _bottomNavBarController = Get.put(BottomNavBarController());
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed, // 3개 이상의 아이템에는 fixed 타입을 사용
      items: _bottomNavBarController.bottomItems,
      currentIndex: _bottomNavBarController.bottomNavCurrentIndex.value,
      selectedItemColor: GlobalBeautyColor.buttonHotPink,
      onTap:(value){ _bottomNavBarController.onItemTapped(value);},
    );
  }
}
