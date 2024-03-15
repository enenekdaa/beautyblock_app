import 'package:beautyblock_app/home/controller/home_bottom_nav_controller.dart';
import 'package:beautyblock_app/home/controller/home_controller.dart';
import 'package:beautyblock_app/home/screen/home_add_detail_info_screen.dart';
import 'package:beautyblock_app/home/screen/home_post_upload_screen.dart';
import 'package:beautyblock_app/utils.dart';
import 'package:beautyblock_app/widget/widget_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_compress/video_compress.dart';
import '../../config.dart';
import '../../widget/widget_drawer.dart';
import '../local_widget/scaffold/home_main_screen_scaffold.dart';

class HomeMainScreen extends StatelessWidget {
  HomeMainScreen({super.key});

  final HomeController _homeController = Get.put(HomeController());
  final ImagePicker _picker = ImagePicker();
  DateTime currentBackPressTime = DateTime.fromMicrosecondsSinceEpoch(0);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        DateTime now = DateTime.now();
        if (BottomNavBarController.to.bottomNavCurrentIndex.value != 0) {
          BottomNavBarController.to.bottomNavCurrentIndex.value = 0;
          return Future.value(false);
        }
        if (BottomNavBarController.to.bottomNavCurrentIndex.value == 0 &&
            HomeController.to.isShowSubscriptionChannel) {
          HomeController.to.toggleShowSubscriptionChannel();
          return Future.value(false);
        } else if (now.difference(currentBackPressTime) >
            const Duration(milliseconds: 1500)) {
          currentBackPressTime = now;
          Fluttertoast.showToast(
              msg: "한번 더 누르면 종료됩니다",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: 14.0);
          return Future.value(false);
        }
        return Future.value(true);
      },
      child: HomeMainScreenScaffold(
        bodySection: _buildBodySection(),
        bottomNavigationSection: BottomNavBar(),
        drawer: DrawerWidget(),
      ),
    );
  }

  Widget _buildBodySection() {
    return Obx(() => BottomNavBarController
        .to.pages.value[BottomNavBarController.to.bottomNavCurrentIndex.value]);
  }
}
