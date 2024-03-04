
import 'package:beautyblock_app/auth/login/controller/login_controller.dart';
import 'package:beautyblock_app/auth/join/controller/join_controller.dart';
import 'package:beautyblock_app/home/controller/home_bottom_nav_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/get_instance.dart';

class InitBinding implements Bindings {
  @override
  void dependencies() {
  Get.put<LoginController>(LoginController());
  Get.put<JoinController>(JoinController());
  Get.put(BottomNavBarController());
  }
}