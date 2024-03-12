import 'package:beautyblock_app/home/controller/home_bottom_nav_controller.dart';
import 'package:beautyblock_app/home/controller/home_controller.dart';
import 'package:beautyblock_app/home/screen/home_add_detail_info_screen.dart';
import 'package:beautyblock_app/home/screen/home_post_upload_screen.dart';
import 'package:beautyblock_app/utils.dart';
import 'package:beautyblock_app/widget/widget_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return HomeMainScreenScaffold(
      bodySection: _buildBodySection(),
      bottomNavigationSection: BottomNavBar(),
      drawer: DrawerWidget(),
    );
  }

  Widget _buildBodySection() {
    return Obx(() => BottomNavBarController.to
        .pages.value[BottomNavBarController.to.bottomNavCurrentIndex.value]);
  }

}
