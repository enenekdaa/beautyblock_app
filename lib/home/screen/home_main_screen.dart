import 'package:beautyblock_app/home/controller/home_bottom_nav_controller.dart';
import 'package:beautyblock_app/home/controller/home_controller.dart';
import 'package:beautyblock_app/home/screen/home_add_detail_info_screen.dart';
import 'package:beautyblock_app/home/screen/home_post_upload_screen.dart';
import 'package:beautyblock_app/utils.dart';
import 'package:beautyblock_app/widget/widget_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config.dart';
import '../local_widget/scaffold/home_main_screen_scaffold.dart';

class HomeMainScreen extends StatelessWidget {
  HomeMainScreen({super.key});

  final BottomNavBarController _bottomNavBarController =
      Get.put(BottomNavBarController());
  final HomeController _homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return HomeMainScreenScaffold(
      bodySection: _buildBodySection(),
      bottomNavigationSection: BottomNavBar(),
      modalBottomSheet: _buildBottomModalSheet(context),
    );
  }

  Widget _buildBodySection() {
    return Obx(() => _bottomNavBarController
        .pages.value[_bottomNavBarController.bottomNavCurrentIndex.value]);
  }

  Widget _buildBottomModalSheet(context) {
    return GestureDetector(
      onVerticalDragUpdate: (details) {
        if (details.delta.dy < 0) {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return Container(
                  height: Get.height * 0.35,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(8.0)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 1,
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: Get.height * 0.02),
                        child: Center(
                          child: Container(
                            width: Get.width * 0.2,
                            height: 4,
                            color: GlobalBeautyColor.tagGray170,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          '영상 Play 만들기',
                          style: AppTheme.smallTitleTextStyle.copyWith(
                              fontSize: 16, fontWeight: FontWeight.w900),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(top: Get.height * 0.01, left: 20),
                        child: GestureDetector(
                          child: Text('카메라/동영상'),
                          onTap: () {
                            Get.to(HomeAddDetailInfoScreen());
                          },
                        ),
                      ),
                      Divider(
                        thickness: 1,
                        color: Color.fromRGBO(230, 230, 230, 1),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: GestureDetector(
                          child: Text('업로드'),
                          onTap: () {
                            Get.to(HomePostUploadScreen());
                          },
                        ),
                      ),
                      Divider(
                        thickness: 1,
                        color: Color.fromRGBO(230, 230, 230, 1),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: GestureDetector(
                          child: Text('스트리밍'),
                          onTap: () {},
                        ),
                      ),
                      Divider(
                        thickness: 1,
                        color: Color.fromRGBO(230, 230, 230, 1),
                      )
                    ],
                  ));
            },
          );
        }
      },
      child: Container(
        height: Get.height * 0.03,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0)),
        child: Center(
          child: Container(
            width: Get.width * 0.2,
            height: 4,
            color: GlobalBeautyColor.tagGray170,
          ),
        ),
      ),
    );
  }
}
