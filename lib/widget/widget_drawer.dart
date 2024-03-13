import 'package:beautyblock_app/home/controller/home_controller.dart';
import 'package:beautyblock_app/home/screen/home_select_country_screen.dart';
import 'package:beautyblock_app/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class DrawerWidget extends StatelessWidget {
  DrawerWidget({super.key});

  final HomeController _homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: EdgeInsets.only(top: Get.height * 0.1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Image.asset(
                'assets/images/ic_main_leading_logo_2.png',
                width: Get.width / 2.5,
              ),
            ),
            Expanded(
                child: ListView.separated(
                    itemCount: _homeController.categories.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 20),
                        dense: true,
                        title: Text(
                          _homeController.categories[index],
                          style: AppTheme.tagTextStyle.copyWith(
                              color: Color.fromRGBO(23, 31, 36, 1),
                              fontWeight: FontWeight.w700),
                        ),
                        onTap: () {
                          print(
                              '${_homeController.categories[index]} is clicked');
                          HomeController.to.selectedSearchCategory.value =
                              _homeController.categories[index];
                          Get.to(HomeSelectCountryScreen());
                        },
                        trailing: SvgPicture.asset(
                            'assets/images/ic_front_arrow.svg'),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Divider(
                          thickness: 1,
                          color: Color.fromRGBO(231, 232, 236, 1),
                        ),
                      );
                    }))
          ],
        ),
      ),
    );
  }
}
