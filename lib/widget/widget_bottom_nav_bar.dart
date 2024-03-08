import 'package:beautyblock_app/config.dart';
import 'package:beautyblock_app/home/controller/home_bottom_nav_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class BottomNavBar extends StatelessWidget {
   BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(()=> BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: BottomNavBarController.to.bottomItems,
        selectedFontSize: 12,
        currentIndex: BottomNavBarController.to.bottomNavCurrentIndex.value,
        selectedItemColor: GlobalBeautyColor.buttonHotPink,
        onTap:(value){
          print(value);
          BottomNavBarController.to.onItemTapped(value);},
      ),
    );
  }
}
